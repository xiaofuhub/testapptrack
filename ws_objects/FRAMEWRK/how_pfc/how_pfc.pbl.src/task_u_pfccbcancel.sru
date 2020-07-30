$PBExportHeader$task_u_pfccbcancel.sru
forward
global type task_u_pfccbcancel from task_u_cbcancel
end type
end forward

global type task_u_pfccbcancel from task_u_cbcancel
end type
global task_u_pfccbcancel task_u_pfccbcancel

event clicked;// Override and call pfc event
parent.TriggerEvent("pfc_cancel")


end event

