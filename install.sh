
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
purple(){
    echo -e "\033[35m\033[01m$1\033[0m"
}

# cài đặt squid
function installsquid(){
yum -y install squid
chkconfig squid on
service squid start
red "đã cài đặt thành công squid"
}

# cài đặt port
function setport(){
service squid restart
sudo systemctl start firewalld
firewall-cmd --permanent --add-port=54321/tcp
firewall-cmd --reload
red "đã khởi động squid và mở thành công port 54321"
}

# tắt ipv6
function offipv6(){
echo "net.ipv6.conf.all.disable_ipv6 = 1" >>  /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >>  /etc/sysctl.conf
sysctl -p
red "đã tắt ipv6 thành công"
}

# menu lệnh
function start_menu() {
    clear
    red "Tool Squid Proxy Design Bởi PTT"
    red "Zalo: 0382.399.633 - 055.987.3663"
    yellow " ————————————————————————————————————————————————"
    green "1. Cài đặt Squid Proxy (cho centos)"
    green "2. Mở port cho Squid (mặc định 54321)"
    green "3. Tắt ipv6 cho VPS"
    green "4. Exit Tool"

    echo
    read -p "Vui lòng ấn số và Enter để chọn chức năng:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           installsquid
	    ;;
        2 )
           setport
        ;;
        3 )
           offipv6
        ;;
        4 )
           exit 1
        ;;
        * )
            clear
            red "nhập đúng số đi sai rùi :)"
            start_menu
        ;;
    esac
}
start_menu "first"
