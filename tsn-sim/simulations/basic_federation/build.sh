# make tsn-sim

src_dir="$LINGUA_FRANCA_TSN_ROOT/tsn-sim/src"

if [ ! -d "$src_dir" ]; then
    mkdir "$src_dir"
fi

cd "$src_dir"
opp_makemake -f --deep -KINET4_5_PROJ=/root/inet4.5 -DINET_IMPORT -L$\(INET4_5_PROJ\)/src -lINET$\(D\)
make MODE=release -j20 all

# make Lingua Franca reactor
cd "$LINGUA_FRANCA_TSN_ROOT/src/basic-federation"
stdbuf -i 0 -o 0 -e 0 \
lfc BasicFederation.lf
