extends Node

#Define Global signals to connect to
#Use to change the interaction UI Icon
signal change_interaction_UI(action)
#redo this for more modularity later, for now emit when buying
signal warehouse_upgrade_bought(item_bought)
#Temporary signal for testing worker spawing
signal bought_worker(workerNumber)
