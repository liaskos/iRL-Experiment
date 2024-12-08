We are modeling a ==heating controller==. The heating controller's purpose is to ==maintain optimal room temperature== at all times. To do so, it sends periodic signals that turn on or off an electric heater. Specifically the controller may choose to send to ==signal the heater on== or ==signal heater off==. These signals are sent wirelessly to the heater, so they are not always received. Thus, when an on signal is sent the outcome can be that the ==On Signal Succeeded== or that the ==On Signal Failed==. Likewise the outcome of an off signal can be ==Off Signal Succeeded== or ==Off Signal Failed==. Whether ==Heater is On== is eventually true depends on which of those four outcomes comes about as well as whether ==Heater was previously On==

The heating controller aims at maintaining optimal room temperature while ==minimizing cost== and ==maximizing comfort==. To minimize cost the controller needs to minimize running time, while to maximize comfort the controller needs to ensure that the ==ideal temperature is maintained==. Whether ideal temperature is maintained, however, depends on (a) the extend to which the ==ideal temperature was maintained at the previous state== (b) whether the heater is on.

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