# update env.sh 
Update the varibles in env.sh if necessary

# Generate configure files for workers
```
sudo apt install -y uuid-runtime
./gen_worker_cfg.sh
```

# Start all workers
```
./workerctl start
./workerctl status
```

# Create tables and views
```
./setup_tpch_tests.sh
```

# Run tpch quries
Test all quereies using external tables
```
./run.sh kite default
```
Test all quereies using internal tables
```
./run.sh memory default
```
Test all quereies using internal tables except lineitem
```
./run.sh memory mixed
```
