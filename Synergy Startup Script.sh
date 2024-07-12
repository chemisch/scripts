

#Synergy client script
#Purpose: Synergy is a virtual KVM, this is a personal script I developed to aid in seemless startup depending on what virtual machine I was running so I could simultanously use the host and virtual machine with the same peripherals.


VM=$(sudo virsh list | grep running | awk '{print $2}')
IP=$(ps -ef | grep synergyc | grep -v grep | awk -F'[: ]' '{print $34}')



if [[ "$IP" == "192.168.0.78" ]]; then
    echo "Yes"
else 
    echo "No"
fi

if [[ "$VM" == "manjaro" ]]; then
    echo "Manjaro is running"
elif [[ "$VM" == "win10" ]]; then
    echo "Windows 10 is running"
else
    echo "Nothing is running"
fi




if [[ -n "$manjaro" ]]; then
    manjarodir=$(ps -eo cmd | grep synergyc | grep -v grep)
    if [[ "$manjarodir" == "/usr/bin/synergyc 192.168.0.78:24800" ]]; then
        echo "Manjaro is running and So is the proper synergyc"
    else
        echo "Manjaro is running but synergyc was not; starting now"
        /usr/bin/synergyc 192.168.0.78:24800    
    fi
elif [[ -n "$win10" ]]; then
    win10dir=$(ps -eo cmd | grep synergyc | grep -v grep)
    if [[ "$win10dir" == "/usr/bin/synergyc 192.168.0.76:24800" ]]; then
        echo "Win10 is running and So is the proper synergyc"
    else
        echo "Win10 is running but synergyc was not starting now"
        /usr/bin/synergyc 192.168.0.76:24800    
    fi
else
    echo "no vm running"
fi


## kill all synergy programs
ps -ef | grep synergyc | grep -v grep | awk '{print $2}' | xargs kill

## write out running virtual machines
sudo virsh list | grep running | awk '{print $2}'

ps -ef | grep synergyc | grep -v grep | awk '{print $2" "$8" "$9}'


#Delimiter for finding ip address of running synergy
ps -ef | grep synergyc | grep -v grep | awk -F'[: ]' '{print $34}'
