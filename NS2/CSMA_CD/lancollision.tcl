set ns [new Simulator]
set nf [open lancollision.nam w]
$ns namtrace-all $nf
set nd [open lancollision.tr w]
$ns trace-all $nd

proc finish { } {
	global ns nf nd
	$ns flush-trace
	close $nf
	close $nd
	exec nam lancollision.nam &
	exec awk -f lancollision.awk lancollision.tr &
	exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns simplex-link $n2 $n3 0.3Mb 100ms DropTail
$ns simplex-link $n3 $n2 0.3Mb 100ms DropTail

set lan [$ns newLan "$n3 $n4 $n5" 0.5Mb 40ms LL Queue/DropTail MAC/Csma/Cd Channel]
#set lan [$ns newLan "$n3 $n4 $n5" 0.5Mb 40ms LL Queue/DropTail MAC/Csma/Cd Channel]

set tcp0 [new Agent/TCP/Newreno]
$ns attach-agent $n0 $tcp0
set sink0 [new Agent/TCPSink/DelAck]
$ns attach-agent $n4 $sink0
$ns connect $tcp0 $sink0
$tcp0 set packet_size_ 552
$tcp0 set fid_ 1

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0


set udp0 [new Agent/UDP]
$ns attach-agent $n1 $udp0
set sink1 [new Agent/Null]
$ns attach-agent $n5 $sink1
$ns connect $udp0 $sink1
$udp0 set fid_ 2

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packet_size_ 1000
$cbr0 set rate_ 0.05Mb
$cbr0 set random_ false
$cbr0 attach-agent $udp0
$cbr0 set type_ CBR

$ns at 0.0 "$n0 label TCP_Traffic"
$ns at 0.0 "$n1 label UDP_Traffic"
$ns at 0.3 "$cbr0 start"
$ns at 0.8 "$ftp0 start"
$ns at 7.0 "$ftp0 stop"
$ns at 7.5 "$cbr0 stop"
$ns at 8.0 "finish"
$ns run 
















