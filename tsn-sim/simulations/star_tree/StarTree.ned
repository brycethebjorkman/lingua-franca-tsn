package tsn_sim.simulations.star_tree;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.ethernet.Eth100M;
import inet.node.ethernet.EthernetSwitch;
import inet.node.inet.StandardHost;
import inet.visualizer.common.IntegratedVisualizer;


network StarTree
{
    parameters:
        @display("bgb=2424.855,1478.265");
    submodules:
        configurator: Ipv4NetworkConfigurator {
            parameters:
                @display("p=608.82,427.425;is=s");
        }
        visualizer: IntegratedVisualizer {
            parameters:
                @display("p=608.82,527.505;is=s");
        }
        localhost: StandardHost {
            parameters:
                @display("p=619.245,1301.04");
        }
        host1: StandardHost {
            parameters:
                @display("p=752.685,1121.73");
        }
        host2: StandardHost {
            parameters:
                @display("p=867.36,1121.73");
        }
        host3: StandardHost {
            parameters:
                @display("p=973.695,1121.73");
        }
        host4: StandardHost {
            parameters:
                @display("p=1069.605,1121.73");
        }
        host5: StandardHost {
            parameters:
                @display("p=1169.6849,1121.73");
        }
        switch0: EthernetSwitch {
            parameters:
                @display("p=1215.5549,1309.38");
        }
        switch1: EthernetSwitch {
            parameters:
                @display("p=994.545,1213.47");
        }
        switch2: EthernetSwitch {
            parameters:
                @display("p=1107.135,1213.47");
        }
        switch3: EthernetSwitch {
            parameters:
                @display("p=1215.5549,1213.47");
        }
        switch4: EthernetSwitch {
            parameters:
                @display("p=1313.5499,1213.47");
        }
        switch5: EthernetSwitch {
            parameters:
                @display("p=1411.5449,1213.47");
        }
        host6: StandardHost {
            parameters:
                @display("p=752.685,1025.82");
        }
        host7: StandardHost {
            parameters:
                @display("p=867.36,1025.82");
        }
        host8: StandardHost {
            parameters:
                @display("p=973.695,1025.82");
        }
        host9: StandardHost {
            parameters:
                @display("p=1069.605,1025.82");
        }
        host10: StandardHost {
            parameters:
                @display("p=1169.6849,1025.82");
        }
        host11: StandardHost {
            parameters:
                @display("p=1259.34,1121.73");
        }
        host12: StandardHost {
            parameters:
                @display("p=1374.015,1121.73");
        }
        host13: StandardHost {
            parameters:
                @display("p=1480.35,1121.73");
        }
        host14: StandardHost {
            parameters:
                @display("p=1578.345,1121.73");
        }
        host15: StandardHost {
            parameters:
                @display("p=1676.34,1121.73");
        }
        host16: StandardHost {
            parameters:
                @display("p=1259.34,1025.82");
        }
        host17: StandardHost {
            parameters:
                @display("p=1374.015,1025.82");
        }
        host18: StandardHost {
            parameters:
                @display("p=1480.35,1025.82");
        }
        host19: StandardHost {
            parameters:
                @display("p=1578.345,1025.82");
        }
        host20: StandardHost {
            parameters:
                @display("p=1676.34,1025.82");
        }
        host21: StandardHost {
            parameters:
                @display("p=752.685,938.25");
        }
        host22: StandardHost {
            parameters:
                @display("p=867.36,938.25");
        }
        host23: StandardHost {
            parameters:
                @display("p=973.695,938.25");
        }
        host24: StandardHost {
            parameters:
                @display("p=1069.605,938.25");
        }
        host25: StandardHost {
            parameters:
                @display("p=1169.6849,938.25");
        }
        host26: StandardHost {
            parameters:
                @display("p=752.685,842.33997");
        }
        host27: StandardHost {
            parameters:
                @display("p=867.36,842.33997");
        }
        host28: StandardHost {
            parameters:
                @display("p=973.695,842.33997");
        }
        host29: StandardHost {
            parameters:
                @display("p=1069.605,842.33997");
        }
        host30: StandardHost {
            parameters:
                @display("p=1169.6849,842.33997");
        }
        host31: StandardHost {
            parameters:
                @display("p=1259.34,938.25");
        }
        host32: StandardHost {
            parameters:
                @display("p=1374.015,938.25");
        }
        host33: StandardHost {
            parameters:
                @display("p=1480.35,938.25");
        }
        host34: StandardHost {
            parameters:
                @display("p=1578.345,938.25");
        }
        host35: StandardHost {
            parameters:
                @display("p=1676.34,938.25");
        }
        host36: StandardHost {
            parameters:
                @display("p=1259.34,842.33997");
        }
        host37: StandardHost {
            parameters:
                @display("p=1374.015,842.33997");
        }
        host38: StandardHost {
            parameters:
                @display("p=1480.35,842.33997");
        }
        host39: StandardHost {
            parameters:
                @display("p=1578.345,842.33997");
        }
        host40: StandardHost {
            parameters:
                @display("p=1676.34,842.33997");
        }
        host41: StandardHost {
            parameters:
                @display("p=752.685,761.02496");
        }
        host42: StandardHost {
            parameters:
                @display("p=867.36,761.02496");
        }
        host43: StandardHost {
            parameters:
                @display("p=973.695,761.02496");
        }
        host44: StandardHost {
            parameters:
                @display("p=1069.605,761.02496");
        }
        host45: StandardHost {
            parameters:
                @display("p=1169.6849,761.02496");
        }
        host46: StandardHost {
            parameters:
                @display("p=752.685,665.115");
        }
        host47: StandardHost {
            parameters:
                @display("p=867.36,665.115");
        }
        host48: StandardHost {
            parameters:
                @display("p=973.695,665.115");
        }
        host49: StandardHost {
            parameters:
                @display("p=1069.605,665.115");
        }
        host50: StandardHost {
            parameters:
                @display("p=1169.6849,665.115");
        }
        host51: StandardHost {
            parameters:
                @display("p=1259.34,761.02496");
        }
        host52: StandardHost {
            parameters:
                @display("p=1374.015,761.02496");
        }
        host53: StandardHost {
            parameters:
                @display("p=1480.35,761.02496");
        }
        host54: StandardHost {
            parameters:
                @display("p=1578.345,761.02496");
        }
        host55: StandardHost {
            parameters:
                @display("p=1676.34,761.02496");
        }
        host56: StandardHost {
            parameters:
                @display("p=1259.34,665.115");
        }
        host57: StandardHost {
            parameters:
                @display("p=1374.015,665.115");
        }
        host58: StandardHost {
            parameters:
                @display("p=1480.35,665.115");
        }
        host59: StandardHost {
            parameters:
                @display("p=1578.345,665.115");
        }
        host60: StandardHost {
            parameters:
                @display("p=1676.34,665.115");
        }
        host61: StandardHost {
            parameters:
                @display("p=752.685,579.63");
        }
        host62: StandardHost {
            parameters:
                @display("p=867.36,579.63");
        }
        host63: StandardHost {
            parameters:
                @display("p=973.695,579.63");
        }
        host64: StandardHost {
            parameters:
                @display("p=1069.605,579.63");
        }
        host65: StandardHost {
            parameters:
                @display("p=1169.6849,579.63");
        }
        host66: StandardHost {
            parameters:
                @display("p=752.685,483.72");
        }
        host67: StandardHost {
            parameters:
                @display("p=867.36,483.72");
        }
        host68: StandardHost {
            parameters:
                @display("p=973.695,483.72");
        }
        host69: StandardHost {
            parameters:
                @display("p=1069.605,483.72");
        }
        host70: StandardHost {
            parameters:
                @display("p=1169.6849,483.72");
        }
        host71: StandardHost {
            parameters:
                @display("p=1259.34,579.63");
        }
        host72: StandardHost {
            parameters:
                @display("p=1374.015,579.63");
        }
        host73: StandardHost {
            parameters:
                @display("p=1480.35,579.63");
        }
        host74: StandardHost {
            parameters:
                @display("p=1578.345,579.63");
        }
        host75: StandardHost {
            parameters:
                @display("p=1676.34,579.63");
        }
        host76: StandardHost {
            parameters:
                @display("p=1259.34,483.72");
        }
        host77: StandardHost {
            parameters:
                @display("p=1374.015,483.72");
        }
        host78: StandardHost {
            parameters:
                @display("p=1480.35,483.72");
        }
        host79: StandardHost {
            parameters:
                @display("p=1578.345,483.72");
        }
        host80: StandardHost {
            parameters:
                @display("p=1676.34,483.72");
        }
        host81: StandardHost {
            parameters:
                @display("p=752.685,398.235");
        }
        host82: StandardHost {
            parameters:
                @display("p=867.36,398.235");
        }
        host83: StandardHost {
            parameters:
                @display("p=973.695,398.235");
        }
        host84: StandardHost {
            parameters:
                @display("p=1069.605,398.235");
        }
        host85: StandardHost {
            parameters:
                @display("p=1169.6849,398.235");
        }
        host86: StandardHost {
            parameters:
                @display("p=752.685,304.41");
        }
        host87: StandardHost {
            parameters:
                @display("p=867.36,304.41");
        }
        host88: StandardHost {
            parameters:
                @display("p=973.695,304.41");
        }
        host89: StandardHost {
            parameters:
                @display("p=1069.605,304.41");
        }
        host90: StandardHost {
            parameters:
                @display("p=1169.6849,304.41");
        }
        host91: StandardHost {
            parameters:
                @display("p=1259.34,398.235");
        }
        host92: StandardHost {
            parameters:
                @display("p=1374.015,398.235");
        }
        host93: StandardHost {
            parameters:
                @display("p=1480.35,398.235");
        }
        host94: StandardHost {
            parameters:
                @display("p=1578.345,398.235");
        }
        host95: StandardHost {
            parameters:
                @display("p=1676.34,398.235");
        }
        host96: StandardHost {
            parameters:
                @display("p=1259.34,304.41");
        }
        host97: StandardHost {
            parameters:
                @display("p=1374.015,304.41");
        }
        host98: StandardHost {
            parameters:
                @display("p=1480.35,304.41");
        }
        host99: StandardHost {
            parameters:
                @display("p=1578.345,304.41");
        }
        host100: StandardHost {
            parameters:
                @display("p=1676.34,304.41");
        }
        host101: StandardHost {
            parameters:
                @display("p=752.685,218.925");
        }
        host102: StandardHost {
            parameters:
                @display("p=867.36,218.925");
        }
        host103: StandardHost {
            parameters:
                @display("p=973.695,218.925");
        }
        host104: StandardHost {
            parameters:
                @display("p=1069.605,218.925");
        }
        host105: StandardHost {
            parameters:
                @display("p=1169.6849,218.925");
        }
        host106: StandardHost {
            parameters:
                @display("p=752.685,120.93");
        }
        host107: StandardHost {
            parameters:
                @display("p=867.36,120.93");
        }
        host108: StandardHost {
            parameters:
                @display("p=973.695,120.93");
        }
        host109: StandardHost {
            parameters:
                @display("p=1069.605,120.93");
        }
        host110: StandardHost {
            parameters:
                @display("p=1169.6849,120.93");
        }
        host111: StandardHost {
            parameters:
                @display("p=1259.34,218.925");
        }
        host112: StandardHost {
            parameters:
                @display("p=1374.015,218.925");
        }
        host113: StandardHost {
            parameters:
                @display("p=1480.35,218.925");
        }
        host114: StandardHost {
            parameters:
                @display("p=1578.345,218.925");
        }
        host115: StandardHost {
            parameters:
                @display("p=1676.34,218.925");
        }
        host116: StandardHost {
            parameters:
                @display("p=1259.34,120.93");
        }
        host117: StandardHost {
            parameters:
                @display("p=1374.015,120.93");
        }
        host118: StandardHost {
            parameters:
                @display("p=1480.35,120.93");
        }
        host119: StandardHost {
            parameters:
                @display("p=1578.345,120.93");
        }
        host120: StandardHost {
            parameters:
                @display("p=1676.34,120.93");
        }
    connections:
        switch1.ethg++ <--> Eth100M <--> switch0.ethg++;
        switch2.ethg++ <--> Eth100M <--> switch0.ethg++;
        switch3.ethg++ <--> Eth100M <--> switch0.ethg++;
        switch4.ethg++ <--> Eth100M <--> switch0.ethg++;
        switch5.ethg++ <--> Eth100M <--> switch0.ethg++;
        localhost.ethg++ <--> Eth100M <--> switch0.ethg++;
        host1.ethg++ <--> Eth100M <--> switch1.ethg++;
        host2.ethg++ <--> Eth100M <--> switch2.ethg++;
        host3.ethg++ <--> Eth100M <--> switch3.ethg++;
        host4.ethg++ <--> Eth100M <--> switch4.ethg++;
        host5.ethg++ <--> Eth100M <--> switch5.ethg++;
        host6.ethg++ <--> Eth100M <--> switch1.ethg++;
        host7.ethg++ <--> Eth100M <--> switch2.ethg++;
        host8.ethg++ <--> Eth100M <--> switch3.ethg++;
        host9.ethg++ <--> Eth100M <--> switch4.ethg++;
        host10.ethg++ <--> Eth100M <--> switch5.ethg++;
        host11.ethg++ <--> Eth100M <--> switch1.ethg++;
        host12.ethg++ <--> Eth100M <--> switch2.ethg++;
        host13.ethg++ <--> Eth100M <--> switch3.ethg++;
        host14.ethg++ <--> Eth100M <--> switch4.ethg++;
        host15.ethg++ <--> Eth100M <--> switch5.ethg++;
        host16.ethg++ <--> Eth100M <--> switch1.ethg++;
        host17.ethg++ <--> Eth100M <--> switch2.ethg++;
        host18.ethg++ <--> Eth100M <--> switch3.ethg++;
        host19.ethg++ <--> Eth100M <--> switch4.ethg++;
        host20.ethg++ <--> Eth100M <--> switch5.ethg++;
        host21.ethg++ <--> Eth100M <--> switch1.ethg++;
        host22.ethg++ <--> Eth100M <--> switch2.ethg++;
        host23.ethg++ <--> Eth100M <--> switch3.ethg++;
        host24.ethg++ <--> Eth100M <--> switch4.ethg++;
        host25.ethg++ <--> Eth100M <--> switch5.ethg++;
        host26.ethg++ <--> Eth100M <--> switch1.ethg++;
        host27.ethg++ <--> Eth100M <--> switch2.ethg++;
        host28.ethg++ <--> Eth100M <--> switch3.ethg++;
        host29.ethg++ <--> Eth100M <--> switch4.ethg++;
        host30.ethg++ <--> Eth100M <--> switch5.ethg++;
        host31.ethg++ <--> Eth100M <--> switch1.ethg++;
        host32.ethg++ <--> Eth100M <--> switch2.ethg++;
        host33.ethg++ <--> Eth100M <--> switch3.ethg++;
        host34.ethg++ <--> Eth100M <--> switch4.ethg++;
        host35.ethg++ <--> Eth100M <--> switch5.ethg++;
        host36.ethg++ <--> Eth100M <--> switch1.ethg++;
        host37.ethg++ <--> Eth100M <--> switch2.ethg++;
        host38.ethg++ <--> Eth100M <--> switch3.ethg++;
        host39.ethg++ <--> Eth100M <--> switch4.ethg++;
        host40.ethg++ <--> Eth100M <--> switch5.ethg++;
        host41.ethg++ <--> Eth100M <--> switch1.ethg++;
        host42.ethg++ <--> Eth100M <--> switch2.ethg++;
        host43.ethg++ <--> Eth100M <--> switch3.ethg++;
        host44.ethg++ <--> Eth100M <--> switch4.ethg++;
        host45.ethg++ <--> Eth100M <--> switch5.ethg++;
        host46.ethg++ <--> Eth100M <--> switch1.ethg++;
        host47.ethg++ <--> Eth100M <--> switch2.ethg++;
        host48.ethg++ <--> Eth100M <--> switch3.ethg++;
        host49.ethg++ <--> Eth100M <--> switch4.ethg++;
        host50.ethg++ <--> Eth100M <--> switch5.ethg++;
        host51.ethg++ <--> Eth100M <--> switch1.ethg++;
        host52.ethg++ <--> Eth100M <--> switch2.ethg++;
        host53.ethg++ <--> Eth100M <--> switch3.ethg++;
        host54.ethg++ <--> Eth100M <--> switch4.ethg++;
        host55.ethg++ <--> Eth100M <--> switch5.ethg++;
        host56.ethg++ <--> Eth100M <--> switch1.ethg++;
        host57.ethg++ <--> Eth100M <--> switch2.ethg++;
        host58.ethg++ <--> Eth100M <--> switch3.ethg++;
        host59.ethg++ <--> Eth100M <--> switch4.ethg++;
        host60.ethg++ <--> Eth100M <--> switch5.ethg++;
        host61.ethg++ <--> Eth100M <--> switch1.ethg++;
        host62.ethg++ <--> Eth100M <--> switch2.ethg++;
        host63.ethg++ <--> Eth100M <--> switch3.ethg++;
        host64.ethg++ <--> Eth100M <--> switch4.ethg++;
        host65.ethg++ <--> Eth100M <--> switch5.ethg++;
        host66.ethg++ <--> Eth100M <--> switch1.ethg++;
        host67.ethg++ <--> Eth100M <--> switch2.ethg++;
        host68.ethg++ <--> Eth100M <--> switch3.ethg++;
        host69.ethg++ <--> Eth100M <--> switch4.ethg++;
        host70.ethg++ <--> Eth100M <--> switch5.ethg++;
        host71.ethg++ <--> Eth100M <--> switch1.ethg++;
        host72.ethg++ <--> Eth100M <--> switch2.ethg++;
        host73.ethg++ <--> Eth100M <--> switch3.ethg++;
        host74.ethg++ <--> Eth100M <--> switch4.ethg++;
        host75.ethg++ <--> Eth100M <--> switch5.ethg++;
        host76.ethg++ <--> Eth100M <--> switch1.ethg++;
        host77.ethg++ <--> Eth100M <--> switch2.ethg++;
        host78.ethg++ <--> Eth100M <--> switch3.ethg++;
        host79.ethg++ <--> Eth100M <--> switch4.ethg++;
        host80.ethg++ <--> Eth100M <--> switch5.ethg++;
        host81.ethg++ <--> Eth100M <--> switch1.ethg++;
        host82.ethg++ <--> Eth100M <--> switch2.ethg++;
        host83.ethg++ <--> Eth100M <--> switch3.ethg++;
        host84.ethg++ <--> Eth100M <--> switch4.ethg++;
        host85.ethg++ <--> Eth100M <--> switch5.ethg++;
        host86.ethg++ <--> Eth100M <--> switch1.ethg++;
        host87.ethg++ <--> Eth100M <--> switch2.ethg++;
        host88.ethg++ <--> Eth100M <--> switch3.ethg++;
        host89.ethg++ <--> Eth100M <--> switch4.ethg++;
        host90.ethg++ <--> Eth100M <--> switch5.ethg++;
        host91.ethg++ <--> Eth100M <--> switch1.ethg++;
        host92.ethg++ <--> Eth100M <--> switch2.ethg++;
        host93.ethg++ <--> Eth100M <--> switch3.ethg++;
        host94.ethg++ <--> Eth100M <--> switch4.ethg++;
        host95.ethg++ <--> Eth100M <--> switch5.ethg++;
        host96.ethg++ <--> Eth100M <--> switch1.ethg++;
        host97.ethg++ <--> Eth100M <--> switch2.ethg++;
        host98.ethg++ <--> Eth100M <--> switch3.ethg++;
        host99.ethg++ <--> Eth100M <--> switch4.ethg++;
        host100.ethg++ <--> Eth100M <--> switch5.ethg++;
        host101.ethg++ <--> Eth100M <--> switch1.ethg++;
        host102.ethg++ <--> Eth100M <--> switch2.ethg++;
        host103.ethg++ <--> Eth100M <--> switch3.ethg++;
        host104.ethg++ <--> Eth100M <--> switch4.ethg++;
        host105.ethg++ <--> Eth100M <--> switch5.ethg++;
        host106.ethg++ <--> Eth100M <--> switch1.ethg++;
        host107.ethg++ <--> Eth100M <--> switch2.ethg++;
        host108.ethg++ <--> Eth100M <--> switch3.ethg++;
        host109.ethg++ <--> Eth100M <--> switch4.ethg++;
        host110.ethg++ <--> Eth100M <--> switch5.ethg++;
        host111.ethg++ <--> Eth100M <--> switch1.ethg++;
        host112.ethg++ <--> Eth100M <--> switch2.ethg++;
        host113.ethg++ <--> Eth100M <--> switch3.ethg++;
        host114.ethg++ <--> Eth100M <--> switch4.ethg++;
        host115.ethg++ <--> Eth100M <--> switch5.ethg++;
        host116.ethg++ <--> Eth100M <--> switch1.ethg++;
        host117.ethg++ <--> Eth100M <--> switch2.ethg++;
        host118.ethg++ <--> Eth100M <--> switch3.ethg++;
        host119.ethg++ <--> Eth100M <--> switch4.ethg++;
        host120.ethg++ <--> Eth100M <--> switch5.ethg++;
}
