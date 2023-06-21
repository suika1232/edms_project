package com.human.springboot.dto;

import lombok.Data;

@Data
public class SwEdmsDTO extends SwEmpDTO{
    
    // edms
    private int edms_id;
    private String edms_category;
    private int edms_drafter;
    private int edms_mid_approver;
    private int edms_fnl_approver;
    private String edms_date;
    private String edms_status;
    private String edms_title;
    private String edms_mid_chk;
    private String edms_fnl_chk;
    private String edms_reason;

    private String mid_name;
    private String final_name;

    // edms_leave
    private int leave_id;
    private String leave_category;
    private String leave_start;
    private String leave_end;
    private String leave_detail;
    private int leave_period;

    // edms_loa
    private int loa_id;
    private String loa_detail;
    private int loa_expense;


}
