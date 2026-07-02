# Vehicle Dynamics & Motion Control — Simulation Portfolio

Simulation, estimation, and control studies in **IPG CarMaker** and **MATLAB/Simulink**, covering tire normal force estimation, yaw dynamics and handling, longitudinal/lateral speed control, sensor-based vehicle speed estimation, and quarter-car vertical dynamics.

Developed as part of **Master's program**, Chalmers University of Technology.

*Engineering Problem → Objective → Model → Results → Insights* structure is compiled in [`vehicle dynamics and motion control.pdf`](./vehicle%20dynamics%20and%20motion%20control.pdf).

## Repository Structure

```
.
├── 01 Normal Force Estimation/     # 4-wheel Fz estimator, roll-stiffness based, warning function
├── 02 Yaw Gain Comparission/       # Bicycle model vs. CarMaker: yaw rate frequency response
├── 03 Cruise and Later Acc Control/ # PI cruise controller + steering-based curve speed limitation
├── 04 Handling Diagram/            # Normalized lateral acc. vs. sideslip balance, IC vs. EV 50/50
├── 05 Vehicle Speed Estimation/    # Wheel-hub speed (trivial + tire-model corrected), CoG transform
├── 06 QCM Vertical Dynamics/       # Quarter-car model: state-space, stability, Bode, invertibility
├── Roads/                          # CarMaker road/track definitions used across the studies
├── Vehicle_parameters_1_to_4.m     # Shared vehicle parameter set (mass, inertia, stiffness, geometry)
└── vehicle dynamics and motion control.pdf   # Full portfolio report
```

## Project Summaries

| # | Folder | What it does |
|---|--------|--------------|
| 1 | `Normal Force Estimation` | Estimates all four tire normal forces from a_x, a_y, roll/yaw rate and roll-stiffness distribution; validated against CarMaker ground truth (RMS 340-435 N); triggers a low-load warning at <2/3 static load. |
| 2 | `Yaw Gain Comparission` | Linear single-track (bicycle) model identified against a CarMaker system-ID model (`iddata`/`tfest`) at 80/110/130 kmph via chirp-steer input; compares Bode gain/frequency response. |
| 3 | `Cruise and Later Acc Control` | PI-based cruise controller tracking a multi-step speed profile (0-120 kmph); curvature-based curve-speed limiter capping target speed to ±2 m/s² lateral acceleration. |
| 4 | `Handling Diagram` | Constant-radius steer-ramp handling diagram comparing an IC baseline against a 50/50 weight-distributed EV variant, plus a re-tuned EV suspension case. |
| 5 | `Vehicle Speed Estimation` | Trivial vs. tire-model-corrected wheel-hub speed per wheel, transformed to CoG, with max-normal-force wheel selection (overall RMS 0.255 m/s) and a parameter-uncertainty analysis. |
| 6 | `QCM Vertical Dynamics` | Quarter-car state-space model: stability check, road-to-sprung-mass Bode response, relative-degree/causal-invertibility analysis, and a hysteresis-based switching strategy for the piecewise-linear (bump/rebound) damper model. |

## Tools

- **IPG CarMaker** — full-vehicle simulation, road/track definition, sensor data logging
- **MATLAB/Simulink** — controller design (PI/PID), state-space modeling, system identification (`iddata`, `tfest`), Bode analysis
- **LaTeX** — portfolio report compilation

## Notes

- `Vehicle_parameters_1_to_4.m` holds the shared vehicle parameter set (mass, CoG geometry, inertia tensor, spring/anti-roll-bar stiffness) used consistently across studies 1-4.
- `Roads/` contains the CarMaker track/road definitions referenced by the normal-force, yaw-gain, handling, and speed-control studies.
- Figures referenced in the PDF report should be exported from the corresponding MATLAB scripts/CarMaker sessions in each numbered folder.
- Numerical results (RMS values, gains, warning-trigger timings) can vary slightly between users depending on how the road/track was generated (waypoint spacing, banking definition, pylon/curve radii) and on modeling assumptions made along the way (e.g., tire/roll-stiffness parameters, controller tuning). Treat the values in this repo as reproducible under the specific `Roads/` definitions and parameter set included here, not as universal constants.

