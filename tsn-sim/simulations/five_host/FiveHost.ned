package tsn_sim.simulations.five_host;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.ethernet.Eth100M;
import inet.node.ethernet.EthernetSwitch;
import inet.node.inet.StandardHost;
import inet.visualizer.common.IntegratedVisualizer;


network FiveHost
{
    parameters:
        @display("bgb=1036.1,652.6");
    submodules:
        configurator: Ipv4NetworkConfigurator {
            parameters:
                @display("p=100,100;is=s");
        }
        visualizer: IntegratedVisualizer {
            parameters:
                @display("p=100,200;is=s");
        }
        host1: StandardHost {
            parameters:
                @display("p=279.456,123.328");
        }
        host2: StandardHost {
            parameters:
                @display("p=392.288,123.328");
        }
        host3: StandardHost {
            parameters:
                @display("p=498.56,123.328");
        }
        host4: StandardHost {
            parameters:
                @display("p=596.96,123.328");
        }
        host5: StandardHost {
            parameters:
                @display("p=695.36,123.328");
        }
        switch0: EthernetSwitch {
            parameters:
                @display("p=498.56,452.64");
        }
        switch1: EthernetSwitch {
            parameters:
                @display("p=279.456,246.656");
        }
        switch2: EthernetSwitch {
            parameters:
                @display("p=392.288,246.656");
        }
        switch3: EthernetSwitch {
            parameters:
                @display("p=498.56,246.656");
        }
        switch4: EthernetSwitch {
            parameters:
                @display("p=596.96,246.656");
        }
        switch5: EthernetSwitch {
            parameters:
                @display("p=695.36,246.656");
        }
    connections:
        host1.ethg++ <--> Eth100M <--> switch1.ethg++;
        host2.ethg++ <--> Eth100M <--> switch2.ethg++;
        host3.ethg++ <--> Eth100M <--> switch3.ethg++;
        host4.ethg++ <--> Eth100M <--> switch4.ethg++;
        host5.ethg++ <--> Eth100M <--> switch5.ethg++;
        switch1.ethg++ <--> Eth100M <--> switch0.ethg++;
        switch2.ethg++ <--> Eth100M <--> switch0.ethg++;
        switch3.ethg++ <--> Eth100M <--> switch0.ethg++;
        switch4.ethg++ <--> Eth100M <--> switch0.ethg++;
        switch5.ethg++ <--> Eth100M <--> switch0.ethg++;
}
