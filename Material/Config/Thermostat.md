We are modeling a ==temperature controller==. The controller's purpose is to have ==the temperature of a room controlled== at all times. To do so, it sends periodic signals that turn on or off the heater. Specifically the controller may choose to ==send an on signal== or to ==send an off signal== to the heater. These signals are sent wirelessly to the heater, so they are not always received. Thus, when an on signal is sent the outcome can be that the ==on-signal succeeded== or that the ==on-signal failed==. Likewise the outcome of an off signal can be ==off-signal succeeded== or ==off-signal failed==. Whether the ==heater is on== is eventually true depends on which of those four outcomes comes about as well as whether ==heater was previously on==. Each time the controller achieves its goal to have the heater controlled, by sending an on or off signal to it, it ==records the action== that was taken and the time it was taken in a log file. Obviously they controller cannot record the action before it has attempted the action first.

The heating controller aims at maintaining optimal room temperature while ==minimizing cost== and ==maximizing comfort==. To minimize cost the controller needs to ==minimize running time==. Every time the heater turns on this obviously hurts running time minimization. To maximize comfort the controller needs to ensure that the ==ideal temperature is maintained== while the heater is controlled. Whether ideal temperature is maintained, however, depends on (a) the extend to which the ==ideal temperature was maintained at the previous state== (b) whether the heater is on.

Entities
- Actor
- Goal
- Task
- Effect
- Pre-Effect
- Quality
- Pre-quality
- None of the above

Relationships
- AND-decomposition
- OR-decomposition
- Effect
- Effect Group
- Contribution
- None of the above