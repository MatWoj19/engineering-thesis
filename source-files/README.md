This thesis examines the quality of control system performance, focusing on the
implementation of a PID controller and its impact on key performance indicators such
as the sum of squared errors (SSE), mean absolute error (MAE), and the Mean
Travel Index. The research investigates the dynamic behaviour of these indicators
under varying control system tuning approaches.

As part of the research, experiments were conducted on a simulator of a real
laboratory object, created in the MATLAB environment, and then on the station itself.
The primary objective was to evaluate the impact of different PID tuning strategies
(normal, fast, slow) on control performance indicators and an analysis of the effects
of using varying sliding window lengths for computing the control performance
indicators.

In the theoretical part, the thesis defines quality in the context of control systems as
the adherence to user requirements and technical standards. It emphasizes the
importance of quality management, including planning, monitoring, and continuous
improvement of the processes. This part also presents the principles of PID control,
and popular tuning methodologies such as the Ziegler-Nichols algorithm, which allow
to adjust controller parameters to specific system requirements.

The practical part involved simulator tests and experiments on a real object. The
simulations reproduced the dynamics of the real system, using a first-order inertial
system with a time delay, enabling fast testing of the PID controller various
configurations. Then experiments were conducted, which enabled comparison of the
simulation results with the actual behaviour of the system.
