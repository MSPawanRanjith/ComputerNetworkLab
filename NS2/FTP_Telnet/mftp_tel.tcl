set ns [new Simulator]
set nf [open mftp_tel.nam w]
$ns namtrace-all $nf
set nd [open mftp_tel.tr w]
$ns trace-all $nd

proc finish { } {
	global ns nf nd
	$ns flush-trace
	close $nf
	close $nd
	exec nam mftp_tel.nam &
	exec awk -f mftp_tel.awk mftp_tel.tr &
	exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns simplex-link $n2 $n3 1Mb 10ms DropTail
$ns simplex-link $n3 $n2 1Mb 10ms DropTail

$ns queue-limit $n0 $n2 10
$ns simplex-link-op $n0 $n2 queuePos 0.5


set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n3 $sink0
$ns connect $tcp0 $sink0
$tcp0 set fid_ 1

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0 
$ftp0 set type_ FTP

set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n3 $sink1
$ns connect $tcp1 $sink1
$tcp1 set fid_ 2

set tel [new Application/Telnet]
$tel attach-agent $tcp1
$tel set type_ Telnet

$ns at 0.5 "$ftp0 start"
$ns at 0.5 "$tel start"
$ns at 24.5 "$ftp0 stop"
$ns at 24.5 "$tel stop"
$ns at 25.0 "finish"

$ns run























