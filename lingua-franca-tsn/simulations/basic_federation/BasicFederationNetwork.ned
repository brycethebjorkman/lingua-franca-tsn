package lingua_franca_tsn.simulations.basic_federation;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.ethernet.Eth100M;
import inet.node.ethernet.EthernetSwitch;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.visualizer.common.IntegratedVisualizer;


network BasicFederation
{
    parameters:
        @display("bgb=1036.63,611.185");
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
                @display("p=298.69,425.44498");
        }
        switch2: EthernetSwitch {
            parameters:
                @display("p=699.035,425.44498");
        }
        router: Router {
            parameters:
                @display("p=499.49,425.44498");
        }
        Federate_c: StandardHost {
            parameters:
                @display("p=99.145,425.44498");
        }
        Federate_p: StandardHost {
            parameters:
                @display("p=899.83496,425.44498");
        }
        RTI: StandardHost {
            @display("p=499.49,222.135");
        }
        switch3: EthernetSwitch {
            parameters:
                @display("p=499.49,330.065");
        }
    connections:
        Federate_c.ethg++ <--> Eth100M <--> switch1.ethg++;
        switch1.ethg++ <--> Eth100M <--> router.ethg++;
        router.ethg++ <--> Eth100M <--> switch2.ethg++;
        switch2.ethg++ <--> Eth100M <--> Federate_p.ethg++;
        RTI.ethg++ <--> Eth100M <--> switch3.ethg++;
        switch3.ethg++ <--> Eth100M <--> router.ethg++;
}
