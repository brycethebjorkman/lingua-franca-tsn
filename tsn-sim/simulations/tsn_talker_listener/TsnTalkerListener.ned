package tsn_sim.simulations.tsn_talker_listener;

import inet.visualizer.common.IntegratedVisualizer;
import inet.networks.base.TsnNetworkBase;
import inet.node.ethernet.EthernetLink;
import inet.node.tsn.TsnClock;
import inet.node.tsn.TsnDevice;
import inet.node.inet.StandardHost;
import inet.node.tsn.TsnSwitch;

network TsnTalkerListener extends TsnNetworkBase
{
    parameters:
        @display("bgb=1216.095,670.17");
    submodules:
        tsnClock1: TsnClock {
            parameters:
                @display("p=729.15497,499.49");
        }
        tsnDevice1: TsnDevice {
            parameters:
                @display("p=389.05,327.555");
        }
        tsnDevice2: TsnDevice {
            parameters:
                @display("p=1108.1649,328.81");
        }
        tsnSwitch1: TsnSwitch {
            parameters:
                eth[*].typename = "EthernetInterface";
                @display("p=729.15497,326.3");
        }
    connections:
        tsnClock1.ethg++ <--> EthernetLink <--> tsnSwitch1.ethg++;
        tsnSwitch1.ethg++ <--> EthernetLink <--> tsnDevice1.ethg++;
        tsnSwitch1.ethg++ <--> EthernetLink <--> tsnDevice2.ethg++;
}
