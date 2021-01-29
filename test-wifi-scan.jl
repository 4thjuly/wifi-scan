include("wifi-scan.jl")

wifi = wifiScanInit("wlan0")
rstation = Ref(station_info())
status = wifiScanStation(wifi, rstation)
if status == 0
    println("No assocation")
elseif status == -1
    println("Unable to get station information")
else 
    println("Signal: $(rstation[].signal_dbm)")
end

wifiScanClose(wifi)