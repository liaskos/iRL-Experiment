Welcome to this presentation of iStar-RL, an agent-based, goal-oriented language for modeling reinforcement learning agents. 

 Reinforcement learning is a form of AI (Artificial Intelligence) in which learning takes place through experience. This is in contrast to other types of machine learning, such as classification and clustering, which are based on existing datasets. Intelligent reinforcement learning agents perform actions in a real or simulated environment. After each action they observe the outcome of the action and how good the outcome is with regards to the agent's objectives. By repeatedly engaging in such action and feedback interactions with the environment, agents accumulate experience that helps them improve their action choices.

When designing such a self-learning agent, we need to somehow describe the available actions, outcomes and qualities of outcomes. iStar-RL is a high-level visual conceptual modeling language that allows us to define exactly that. 

A conceptual modeling language, like iStar-RL, offers a set of concepts that modelers can use in order to develop models in the language. There are two categories of concepts, entities which are distinct concepts to be modeled, and relationships, which represent an association or interaction between two or more entities.

So let us then see what are the entities and relationships encompasing iStar-RL. The entities of iStar RL are:
- Actors
- Goals
- Tasks
- Effects
- Effect (non-satisfying)
- Effect (indirect)
- Qualities (present satisfaction state)
- Pre-Effects
- Pre-Qualities
the relationships supported by iStar RL are:
- AND-refinement
- OR-refinement
- Effect
- Contribution
- Precedence

Let us look at all these concepts in more detail.

- An **actor** is a an active, autonomous entity that holds beliefs and aims at achieving goals. It can be, for example, a human or, more likely in our case, an artificial intelligence system. Examples of actors include: 
	- Student (in an education context)
	- Nurse (in a health care context)
	- Participant (in a scientific study like this one)
	- Flight controller (in an aviation context)
- Istar-RL is a visual language, so we represent concepts as visual elements. So we represent actors using a special circular element, like so. They are drawn with a boundary whose meaning we will discuss shortly.

- **Actors** have **goals**. Goals are states of affairs that an actor wants to achieve. Here are some examples:
	- Course requirements fulfilled
	- Book acquired
	- Medical Test Completed
	- Medical supplies replenished
	- Experimental tasks accomplished
- We use these oval-shaped elements to represent goals. 
- To denote that a goal is wanted by an actor we place the oval in a shaded area that includes all the goals that the actor has. This is the actor boundary we showed earlier. So, for example, the student has two goals, "Course Requirements Fulfilled" and "Book Acquired". So there is a wants relationship between "Student" and "Course Requirements Fulfilled" and between "Student and Book Acquired". 

* So, so far we have actors, and these actors have goals. But, how can they achieve their goals? By performing, tasks. A task is an attempt to an action by an actor, usually with the purpose of achieving some goal. Here are some examples of tasks: 
	* Enroll course
	* Complete homework assignment
	* Write exam
	* Acquire blood sample
	* Order supplies online
	* Purchase supplies in person from the store.
* We use these hexagonal-shaped elements to represent tasks.
* Now, like we said, tasks are performed for fulfilling goals. We then need to show how tasks fulfill goals. To do so we use refinement relationships. There are two varieties of refinements AND-refinements and OR-refinements. 
* An **AND-refinement** shows how a goal can be decomposed into multiple tasks, the performance of all of which child tasks is necessary for the fulfillment of the parent goal. Thus, to achieve goal "course requirements fulfilled", a student needs to enroll the course, do the assignments, and pass an exam. All of these need to be performed in order for the parent goal to be satisfied, so it is a AND-refinement. We denote AND-refinements through adding special decorations on the links that connect the parent and the children.
* An **OR-refinement** shows how a goal can be decomposed into alternative tasks, one of which is sufficient for the fulfillment of the parent goal. To fulfill goal "Have supplies replenished" an inventory manager of a hospital may "order supplies online" or, alternativel,y go and "purchase supplies in person from the store". Doing one of the two will suffice for the fulfilment of the goal. 
* We represent an OR-refinement using different decorations on the links from the ones we use for the AND-refinements.
* So we have goals and tasks and refinements of the former to the latter. We also have **qualities**. A quality is an attribute for which an actor desires some level of achievement. For example the Student wants to "Develop New Skills" and the Inventory Manager to "Reduce Costs" and "Expedite Delivery". We represent qualities using the cloud-shaped elements like you see on the screen.
* Now, qualities are assumed to be satisfied to some degree based on what tasks actors perform. We represent this through contribution relationships. 
* When a we draw a contribution link from an origin element to a target element, we denote that performance or satisfaction of the origin of the link affects satisfaction of the target of the link. We represent this using a link like so. Targets are always qualities, but origins of contribution links can be, goals, tasks, effects, and other qualities.
* 
* If we know that the contribution is positive, that is, satisfaction or performance of the origin supports the satisfaction of the destination, then it is a positive contribution. When we know that the opposite is true, that is, satisfaction of the origin actually hurts satisfaction of the destination, the quality contribution is negative. We denote positive and negative contributions by decorating the contribution link with a positive or negative number, respectively. The larger the number in absolute terms the stronger the positive or negative contribution accordingly.
* Let's look at the example. For the "Inventory Manager", ordering supplies on-line is the cheaper option but also the slower, as they have to wait for the delivery. So performing the task has a positive contribution to quality "Reduce Costs" but a negative contribution to quality "Expedite Delivery". If the quality and size of the contribution is not straightforward but depends on complex calculations specified elsewhere, instead of a number we add an f annotation. Here for example we denote that how purchasing the supplies for the store affects product quality depends on several complex factors not mentioned in the diagram.

Let us now focus on tasks. As we know from our daily life when we attempt a task it does not always succeed. For example when you try to pay by card for a purchase, most of the times   the transaction is accepted, but sometimes times it is not. For some tasks this uncertainty of outcome is expected. For example when writing an exam, you may pass it with a good grade, pass it with an OK grade, or fail it. To show the relationship between tasks and their various outcomes, we use effect elements and effect links. 
- Effect elements describe state of affairs that emerge from the performance of a task. For example "Exam passed with high grade" is an effect and so is "Exam passed with OK grade", "Exam failed", and "Participation was not possible". These are all alternative outcomes of task "Write Exam". To represent this we use the effect relationship. A task produces a group of effects, when attempt of the former brings about one of the latter.
- Visually we use ovals to represent effects and we group them together by having all of them point to the same thick dot. Then an effect link from the task to the group is drawn, to exactly show that attempt of the task will bring about one of the effects in the group. The link from a task to an effect group like this is called a non-deterministic effect link, exactly because it implies that which effect will occur is not pre-determined.

Not all tasks have the same status in the group. If a student's task is to "Write Exam" the first three of the outcomes signify accomplishment of the task. The exam was written even if it was failed. So the first three effects are, what we call task-satisfying effects: when they occur the parent task can be considered accomplished. 

However the fourth effect "Participation was not possible" is non-satisfying of the task. For whatever logistical reason the student was not able to participate (e.g., they didn't have their name in the examinee list) so the exam was not actually written. So this effect group has three satisfying and one non-satisfying effect. The latter is marked with a different color and an annotation.

Moreover, effects can automatically bring about other effects. So for example that "Exam passed with high grade" may mean that effect "Eligiblie for Scholarship" is also brought about. We call these indirect effects, as they are not directly connected to a task, and we annotated with the "I" letter. The direct and indirect effect are then simply connected with an effect link. This is an deterministic effect link, as the destination of the link is a sole effect element rather than a group. If the nature of the effect is complicated, for example complex conditions apply, we again add an f to denote this. Hence, there are two possibilities to draw an effect link. One is from from a task to an effect group, and the other is from an effect to another effect. Recall also that effects can contribute to qualities. For example the occurrence "Eligibile for Scholarship" contributes positively to quality "Maximize Financial Support".

Let us come back to tasks. We may want to denote that tasks need to be performed in allowed order. For example, one cannot pass a course unless they enroll it first. Or supplies cannot be received unless they are ordered first. We use a precedence link to denote that.

When a goal or task is the origin of a precedence link towards a task, the task cannot be performed unless the origin goal is satisfied or the origin task is performed. Thus, task "dispute grade" cannot be performed unless the exam has actually been given, that is, the task had a satisfying effect. It follows in this example that if the fourth effect is actually brought about, the task is not accomplished and the precedence link prevents the student to perform the task that is pointed by the link.

## Pre

There is one more thing to consider before we conclude this presentation. In iStar-RL models we can refer to the previous status of  both effects and qualities using what we call pre-effects and pre-qualities. Let us say that a robotic agent performs the task of pressing a light switch. Once pressed, the light switch will turn the lights of a room on if they were off, or turn them off if they were on. So what would the outcome of the task "Press Switch" be then?

We use a pre-effect element to describe the state of the environment before a task was performed. In our example we use a pre-effect to describe the status of the lights as brought about in the previous press of the switch button. This pre-effect, together with the effect of the current press action, will decide the indirect effect of whether the lights will be on or off. Hence, the robot presses the button, and the pressing will most likely succeed. There is of course the odd case in which the robot actually misses the switch and it is not even pressed. So whether it is pressed or not is the direct effect of the action. The indirect effect is whether the lights will be on or off and this depends on what they were before the switch was pressed. If they were on, they will no be off. If they were off they will now be on.

Diagrammatically we represent this by having the the indirect effect "Lights are On" receives effect links both from "Switch Pressed" and from the pre-effect which denotes the status of the lights before the task was performed. We use the f annotation to signal that the exact logic of how the two incoming effect links are combined is described somewhere outside the diagram.

The same idea can be applied to qualities. Let's say that my quality is to "Improve Understanding of iStar-RL" the language we discuss here. Every time I watch this video it may add or subtract to my understanding of the language. In other words, my new understanding of iStar-RL will be based on my previous understanding of iStar-RL plus or minus the effect that watching the video had on my understanding of iStar-RL. We represent this through adding a pre-quality element as you see in this model. So I make an attempt to watch the video (which may fail), and my understanding of iStar-RL will be the understanding of iStar-RL I already had plus or minus whatever one more viewing added or subtracted to what I thought I already understood. Again the f here means that the exact mathematical or other specification of these relationships is complex and is described elsewhere.

So this concludes the presentation of this language, thank you for your patience. 








