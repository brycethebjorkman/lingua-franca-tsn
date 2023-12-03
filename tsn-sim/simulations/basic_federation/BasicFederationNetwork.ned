package tsn_sim.simulations.basic_federation;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.ethernet.Eth100M;
import inet.node.ethernet.EthernetSwitch;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.visualizer.common.IntegratedVisualizer;


network BasicFederation
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
        localhost: StandardHost {
            parameters:
                @display("p=860.6,353.6");
        }
        RTI: StandardHost {
            @display("p=499.19998,139.09999");
        }
        Federate_c: StandardHost {
            parameters:
                @display("p=165.09999,353.6");
        }
        Federate_p: StandardHost {
            parameters:
                @display("p=499.19998,598");
        }
        switch1: EthernetSwitch {
            parameters:
                @display("p=687.7,352.3");
        }
        switch2: EthernetSwitch {
            parameters:
                @display("p=499.19998,260");
        }
        switch3: EthernetSwitch {
            parameters:
                @display("p=340.6,352.3");
        }
        switch4: EthernetSwitch {
            parameters:
                @display("p=499.19998,474.5");
        }
        switch5: EthernetSwitch {
            parameters:
                @display("p=499.19998,352.3");
        }
    connections:
        localhost.ethg++ <--> Eth100M <--> switch1.ethg++;
        switch1.ethg++ <--> Eth100M <--> switch5.ethg++;
        RTI.ethg++ <--> Eth100M <--> switch2.ethg++;
        switch2.ethg++ <--> Eth100M <--> switch5.ethg++;
        Federate_c.ethg++ <--> Eth100M <--> switch3.ethg++;
        switch3.ethg++ <--> Eth100M <--> switch5.ethg++;
        Federate_p.ethg++ <--> Eth100M <--> switch4.ethg++;
        switch4.ethg++ <--> Eth100M <--> switch5.ethg++;
}
