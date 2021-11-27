import sys
import serial
import serial.tools.list_ports
from PyQt5 import QtWidgets
from PyQt5.QtWidgets import QMessageBox
from PyQt5.QtCore import QTimer
import matplotlib
matplotlib.use("Qt5Agg")
import BL
from Ui import *

class Pyqt5_Serial(QtWidgets.QWidget, Ui_Form):
    def __init__(self):
        super(Pyqt5_Serial, self).__init__()
        self.setupUi(self)
        self.init()
        self.setWindowTitle("HNU_LPF上位机")
        self.ser = serial.Serial()

        # 接收数据和发送数据数目置零
        self.data_num_received = 0
        self.lineEdit_2.setText(str(self.data_num_received))
        self.data_num_sended = 0
        self.lineEdit.setText(str(self.data_num_sended))

    def init(self):

        self.begin_v.clicked.connect(self.startPlot)
        self.stop_v.clicked.connect(self.pausePlot)
        # 打开串口按钮
        self.open_button.clicked.connect(self.port_open)
        # 关闭串口按钮
        self.close_button.clicked.connect(self.port_close)
        # 发送数据按钮
        self.send_button.clicked.connect(self.data_send)
        # 定时发送数据
        self.timer_send = QTimer()
        self.timer_send.timeout.connect(self.data_send)
        self.send_t_c.stateChanged.connect(self.data_send_timer)
        # 定时器接收数据
        self.timer = QTimer(self)
        self.timer.timeout.connect(self.data_receive)
        # 清除发送窗口
        self.clear_s_button.clicked.connect(self.send_data_clear)
        # 清除接收窗口
        self.clear_res_button.clicked.connect(self.receive_data_clear)

    #开始显示
    def startPlot(self):
        self.mplCanvas.startPlot()
        pass
    #暂停显示
    def pausePlot(self):
        self.mplCanvas.pausePlot()
        pass

    #清空并退出
    def releasePlot(self):
        self.mplCanvas.releasePlot()

    def closeEvent(self, event):
        result = QtWidgets.QMessageBox.question(self,
                                            "提示",
                                            "确定关闭界面吗?",
                                            QtWidgets.QMessageBox.Yes | QtWidgets.QMessageBox.No)
        event.ignore()
        if result == QtWidgets.QMessageBox.Yes:
            self.releasePlot()  # release thread's resouce
            event.accept()


    # 打开串口
    def port_open(self):
        self.ser.port = self.comboBox.currentText()
        self.ser.baudrate = int(self.comboBox_2.currentText())
        self.ser.bytesize = int(self.comboBox_3.currentText())
        self.ser.stopbits = int(self.comboBox_5.currentText())
        self.ser.parity = self.comboBox_4.currentText()

        try:
            self.ser.open()
        except:
            QMessageBox.critical(self, "Port Error", "此串口不能被打开！")
            return None

        # 打开串口接收定时器，周期为2ms
        self.timer.start(2)

        if self.ser.isOpen():
            self.open_button.setEnabled(False)
            self.close_button.setEnabled(True)
            self.groupBox.setTitle("串口状态（已开启）")

    # 关闭串口
    def port_close(self):
        self.timer.stop()
        self.timer_send.stop()
        try:
            self.ser.close()
        except:
            pass
        self.open_button.setEnabled(True)
        self.close_button.setEnabled(False)
        self.t_edi.setEnabled(True)
        # 接收数据和发送数据数目置零
        self.data_num_received = 0
        self.lineEdit_2.setText(str(self.data_num_received))
        self.data_num_sended = 0
        self.lineEdit.setText(str(self.data_num_sended))
        self.groupBox.setTitle("串口状态（已关闭）")

    # 发送数据
    def data_send(self):
        if self.ser.isOpen():
            input_s = self.send_edi.toPlainText()
            if input_s != "":
                # 非空字符串
                if self.send_c.isChecked():
                    # hex发送
                    input_s = input_s.strip()
                    send_list = []
                    while input_s != '':
                        try:
                            num = int(input_s[0:2], 16)
                        except ValueError:
                            QMessageBox.critical(self, 'wrong data', '请输入十六进制数据，以空格分开!')
                            return None
                        input_s = input_s[2:].strip()
                        send_list.append(num)
                    input_s = bytes(send_list)
                else:
                    # ascii发送
                    input_s = (input_s + '\r\n').encode('utf-8')

                num = self.ser.write(input_s)
                self.data_num_sended += num
                self.lineEdit.setText(str(self.data_num_sended))
        else:
            pass

    # 接收数据
    def data_receive(self):
        try:
            BL.num = self.ser.inWaiting()
        except:
            self.port_close()
            return None
        if BL.num > 0:
            BL.data = self.ser.read(BL.num)
            BL.leng = len(BL.data)
            # hex显示
            if self.res_c.checkState():
                out_s = ''
                for i in range(0, len(BL.data)):
                    out_s = out_s + '{:02X}'.format(BL.data[i]) + ' '
                self.rec_txt.insertPlainText(out_s)
            else:
                # 串口接收到的字符串为b,'123'要转化成unicode字符串才能输出到窗口中去
                self.rec_txt.insertPlainText(BL.data.decode('utf-8'))

            # 统计接收字符的数量
            self.data_num_received += BL.leng
            self.lineEdit_2.setText(str(self.data_num_received))

            # 获取到text光标
            textCursor = self.rec_txt.textCursor()
            # 滚动到底部
            textCursor.movePosition(textCursor.End)
            # 设置光标到text中去
            self.rec_txt.setTextCursor(textCursor)
            BL.num = 0
            BL.leng = 0
        else:
            pass

    # 定时发送数据
    def data_send_timer(self):
        if self.send_t_c.isChecked():
            self.timer_send.start(int(self.t_edi.text()))
            self.t_edi.setEnabled(False)
        else:
            self.timer_send.stop()
            self.t_edi.setEnabled(True)

    # 清除显示
    def send_data_clear(self):
        self.send_edi.setText("")

    def receive_data_clear(self):
        self.rec_txt.setText("")

if __name__ == '__main__':
    app = QtWidgets.QApplication(sys.argv)
    myshow = Pyqt5_Serial()
    myshow.show()
    sys.exit(app.exec_())
