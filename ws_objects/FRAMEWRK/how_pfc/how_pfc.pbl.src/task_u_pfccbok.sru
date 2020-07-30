$PBExportHeader$task_u_pfccbok.sru
forward
global type task_u_pfccbok from task_u_cbok
end type
end forward

global type task_u_pfccbok from task_u_cbok
end type
global task_u_pfccbok task_u_pfccbok

event clicked;// Override and call pfc event
parent.TriggerEvent("pfc_default")


end event

