# make tsn-sim

cd $LINGUA_FRANCA_TSN_ROOT/tsn-sim/src
opp_makemake -f --deep -KINET4_5_PROJ=/root/inet4.5 -DINET_IMPORT -L$\(INET4_5_PROJ\)/src -lINET$\(D\)
make MODE=release -j20 all

# make Lingua Franca reactor
cd $LINGUA_FRANCA_TSN_ROOT
stdbuf -i 0 -o 0 -e 0 \
lfc src/basic-federation/BasicFederation.lf
