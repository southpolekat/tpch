# update env.sh 
Update the varibles in env.sh if necessary

# Generate configure files for workers
```
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
```
./run.sh kite 
./run.sh default
```
