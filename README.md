# CDC - CupCarbon Wireless Sensor Network Simulation

Simulation of a wireless sensor network (WSN) using [CupCarbon](https://cupcarbon.com/) v7.2 (Klines). The network consists of a base station coordinating 20 sensor nodes over ZIGBEE protocol, deployed in a geographical area centered in Bogota, Colombia.

> Course: MISW-4401 - Communication in Wireless Networks

## Network Architecture

| Component | Count | IDs | Script |
|-----------|-------|-----|--------|
| Base Station | 1 | 93 | `base.csc` |
| Sensor Nodes | 20 | 146 - 165 | `sensor.csc` |

- **Protocol:** ZIGBEE (IEEE 802.15.4)
- **Network ID:** 13108
- **Radio Radius:** 100 m
- **Data Rate:** 250,000 bps

## How It Works

### Base Station (`scripts/base.csc`)
1. Broadcasts a discovery message (`"hola"`) to the network.
2. Listens for incoming messages from sensors:
   - **`alerta`** - Logs the sensor's GPS coordinates (longitude, latitude).
   - **`critico`** - A sensor has critically low battery. Sends a `"stop"` command and shuts down.

### Sensor Nodes (`scripts/sensor.csc`)
1. Wait for the base station's discovery message and register its ID.
2. Enter a monitoring loop:
   - Relay alert messages to the base station.
   - Stop on command from the base station (and propagate the stop to neighbors).
   - Send a **critical alert** when battery drops below 5%.
   - Report a counter value each iteration (up to 1,000 iterations).

## Project Structure

```
cdc/
├── cdc.cup                       # CupCarbon project file
├── scripts/
│   ├── base.csc                  # Base station behavior script
│   └── sensor.csc                # Sensor node behavior script
├── config/
│   ├── simulationParams.cfg      # Simulation parameters
│   ├── nodes/                    # Node configuration (position, type, script)
│   │   ├── basestation_93
│   │   └── sensor_146 .. sensor_165
│   └── sensor_radios/            # Radio module configuration per node
│       ├── basestation_93
│       └── sensor_146 .. sensor_165
├── results/
│   └── wisen_simulation.csv      # Simulation output (battery levels over time)
├── logs/                         # Simulation logs
├── gps/                          # GPS data
├── natevents/                    # Natural events
├── network/                      # Network topology data
├── xbee/                         # XBee data
└── tmp/                          # Temporary files
```

## Simulation Parameters

| Parameter | Value |
|-----------|-------|
| Simulation time | 86,400 s (24 hours) |
| Simulation speed | 1,000x real-time |
| Results writing period | 0.1 s |
| Mobility | Enabled |
| MAC layer | Disabled |
| Symmetrical links | Enabled |
| Acknowledgments | Disabled |

## Prerequisites

- [CupCarbon Simulator](https://cupcarbon.com/) v7.2 or later

## Running the Simulation

1. Open CupCarbon.
2. Load the project file `cdc.cup`.
3. Run the simulation from the CupCarbon GUI.
4. Results are written to `results/wisen_simulation.csv` containing battery levels for all 21 nodes sampled over the simulation period.

## Results

The simulation outputs a CSV file (`results/wisen_simulation.csv`) with columns:

- **Time (Sec)** - Simulation timestamp
- **S93** - Base station energy
- **S146 - S165** - Battery level (%) for each sensor node

## Authors

- Carlos Garcia (cj.garcias1@uniandes.edu.co)
