set ns [new Simulator]
set nf [open lancollision.nam w]
$ns namtrace-all $nf
set error_rate 0.02
set nd [open lancollision.tr w]
$ns trace-all $nd

proc finish { } {
	global ns nf nd
	$ns flush-trace
	close $nf
	close $nd
	exec nam lancollision.nam &
	exec awk -f error.awk lancollision.tr &
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


set lan [$ns newLan "$n3 $n4 $n5" 0.5Mb 40ms LL Queue/DropTail MAC/802_3 Channel]
#set lan [$ns newLan "$n3 $n4 $n5" 0.5Mb 40ms LL Queue/DropTail MAC/Csma/Cd Channel]
$ns queue-limit $n2 $n3 20
$ns simplex-link-op $n2 $n3 queuePos 0.5
set tcp0 [new Agent/TCP/Newreno]
$ns attach-agent $n0 $tcp0
set sink0 [new Agent/TCPSink/DelAck]
$ns attach-agent $n4 $sink0
$ns connect $tcp0 $sink0
$tcp0 set packet_size_ 552
$tcp0 set fid_ 1

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

set loss [new ErrorModel]
$loss ranvar [new RandomVariable/Uniform]
$loss drop-target [new Agent/Null] 
$loss set rate_ $error_rate
$ns lossmodel $loss $n2 $n3

set udp0 [new Agent/UDP]
$ns attach-agent $n1 $udp0
set sink1 [new Agent/Null]
$ns attach-agent $n5 $sink1
$ns connect $udp0 $sink1
$udp0 set fid_ 2

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packet_size_ 1000
$cbr0 set rate_ 0.2Mb
$cbr0 set random_ false
$cbr0 attach-agent $udp0
$cbr0 set type_ CBR

$ns at 0.1 "$cbr0 start"
$ns at 1.0 "$ftp0 start"
$ns at 124.0 "$ftp0 stop"
$ns at 124.5 "$cbr0 stop"
$ns at 125.0 "finish"

$ns run 
















