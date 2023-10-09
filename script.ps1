#  les détails de la VM

$VMName = "MaVMWinServ"
$VMPath = "D:\vm"  # le chemin de la VM
$VMMemory = 2048MB  #  la quantité de mémoire
$VMDiskSize = 32GB  #  la taille du disque dur
$ISOPath = "C:\Users\aboubakeur.trichine\Downloads\SERVER_EVAL_x64FRE_en-us.iso" #  le chemin de l'ISO de Windows Server# Créez un nouveau disque dur virtuel pour la VM
 # Chemin vers votre fichier de réponse
$AnswerFilePath = "D:\script\Autounattend.xml"

# Créez un nouveau disque dur virtuel pour la VM

Add-VMDvdDrive -VMName $VMName -Path $ISOPath -ControllerLocation 0 -ControllerNumber 1
New-VHD -Path "$VMPath\$VMName.vhdx" -SizeBytes $VMDiskSize -Dynamic

# Créez une nouvelle machine virtuelle
New-VM -Name $VMName -MemoryStartupBytes $VMMemory -Path $VMPath
# joign le disque dur virtuel à la VM
Add-VMHardDiskDrive -VMName $VMName -Path "$VMPath\$VMName.vhdx"
# joigne l'ISO de Windows Server à la VM
Add-VMDvdDrive -VMName $VMName -Path $ISOPath
# Spécifiez le fichier de réponse pour l'installation automatisée
Set-VMFirmware -VMName $VMName -FirstBootDevice DVD
Set-VMDvdDrive -VMName $VMName -Path $ISOPath -ControllerNumber 1 -ControllerLocation 0 -UsePhysicalDrive $false
# Démarrez la VM
Start-VM -Name $VMName

