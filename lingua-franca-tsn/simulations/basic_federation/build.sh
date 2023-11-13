# make lingua-franca-tsn

cd $LINGUA_FRANCA_TSN_ROOT/lingua-franca-tsn/src
opp_makemake -f --deep -KINET4_5_PROJ=/root/inet4.5 -DINET_IMPORT -L$\(INET4_5_PROJ\)/src -lINET$\(D\)
make MODE=release -j20 all
