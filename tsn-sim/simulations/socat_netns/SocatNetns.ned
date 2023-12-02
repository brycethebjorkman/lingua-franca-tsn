package tsn_sim.simulations.socat_netns;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.ethernet.Eth100M;
import inet.node.ethernet.EthernetSwitch;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.visualizer.common.IntegratedVisualizer;


network SocatNetns
{
    parameters:
        @display("bgb=1000,400");
    submodules:
        configurator: Ipv4NetworkConfigurator {
            parameters:
                @display("p=100,100;is=s");
        }
        visualizer: IntegratedVisualizer {
            parameters:
                @display("p=100,200;is=s");
        }
        switch1: EthernetSwitch {
            parameters:
                @display("p=300,300");
        }
        switch2: EthernetSwitch {
            parameters:
                @display("p=700,300");
        }
        host1: StandardHost {
            parameters:
                @display("p=100,300");
        }
        host2: StandardHost {
            parameters:
                @display("p=900,300");
        }
        switch3: EthernetSwitch {
            parameters:
                @display("p=490.705,299.94498");
        }
    connections:
        host1.ethg++ <--> Eth100M <--> switch1.ethg++;
        switch2.ethg++ <--> Eth100M <--> host2.ethg++;
        switch1.ethg++ <--> Eth100M <--> switch3.ethg++;
        switch3.ethg++ <--> Eth100M <--> switch2.ethg++;
}
