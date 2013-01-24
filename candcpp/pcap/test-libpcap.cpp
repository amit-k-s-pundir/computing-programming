pcap_lookupdev();
pcap_t* handler = pcap_open_live(devicd, snaplen, promisc, to_ms, errbuf);
