const WifiScanLib = "wifi_scan"

const BSSID_LENGTH = 6
const BSSID_STRING_LENGTH = 18
const SSID_MAX_LENGTH_WITH_NULL = 33

const BSS_STATUS_BSS_NONE = -1
const BSS_STATUS_BSS_AUTHENTHICATED = 0
const BSS_STATUS_BSS_ASSOCIATED = 1
const BSS_STATUS_BSS_IBSS_JOINED = 2

struct station_info
    bssid::NTuple{BSSID_LENGTH, UInt8}
    ssid::NTuple{SSID_MAX_LENGTH_WITH_NULL, Cuchar}
    bss_status::Cuint
    signal_dbm::Int8
    signal_avg_dbm::Int8
    rx_packets::Cuint
    tx_packets::Cuint
    station_info() = new(tuple(zeros(UInt8, BSSID_LENGTH)...), tuple(zeros(Cuchar, SSID_MAX_LENGTH_WITH_NULL)...), Cuint(0), Int8(0), Int8(0), Cuint(0), Cuint(0))
end

wifiScanInit(device::String) = @ccall WifiScanLib.wifi_scan_init(device::Cstring)::Ptr{Cvoid}
wifiScanClose(wifi::Ptr{Cvoid}) = @ccall WifiScanLib.wifi_scan_close(wifi::Ptr{Cvoid})::Cvoid
wifiScanStation(wifi::Ptr{Cvoid}, station::Ref{station_info}) = @ccall WifiScanLib.wifi_scan_station(wifi::Ptr{Cvoid}, station::Ptr{station_info})::Cint
