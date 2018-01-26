set ns [new Simulator]
set nf [open m4nodeptp.nam w]
$ns namtrace-all $nf
set nd [open m4nodeptp.tr w]
$ns trace-all $nd

proc finish { } {
	global ns nf nd
	$ns flush-trace
	close $nf
	close $nd
	exec nam m4nodeptp.nam &
	exec awk -f m4nodeptp.awk m4nodeptp.tr &
	exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$n0 color Blue
$n1 color Red
$n2 color Green
$n3 color Purple

$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0

set sink0 [new Agent/TCPSink]
$ns attach-agent $n3 $sink0
$ns connect $tcp0 $sink0
$tcp0 set fid_ 1

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ftp0 set type_ FTP

set udp0 [new Agent/UDP]
$ns attach-agent $n1 $udp0

set sink1 [new Agent/Null]
$ns attach-agent $n3 $sink1
$ns connect $udp0 $sink1
$udp0 set fid_ 2

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0
$cbr0 set type_ CBR

$ns at 0.2 "$cbr0 start"
$ns at 0.1 "$ftp0 start"
$ns at 4.5 "$cbr0 stop"
$ns at 4.4 "$ftp0 stop"
$ns at 5.0 "finish"
$ns run




































