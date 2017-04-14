---
title: Filter functionality in Moodle Configurable Reports
categories:
    - Moodle
tags:
    - Moodle
    

---
This post describes the filter functionality in Moodle Configurable Reports.

##Create the sql query
        
        SELECT *
        from prefix_course
        WHERE
        1=1
        %%FILTER_COURSES:prefix_course.id%%
        %%FILTER_SEARCHTEXT:prefix_course.fullname:~%%
        
##Add filter fields

Available filters are located in: `components/filters/` of Configurable Reports.

In the `filters` tab:  

 - add `Courses` that will refer to `%%FILTER_COURSES:prefix_course.id%%`
 
 - add `Search text` that will refer to `%%FILTER_SEARCHTEXT:prefix_course.fullname:~%%`

###Available variables

    %%CATEGORYID%%
    %%COURSEID%%
    %%CURRENTUSER%%
    %%DEBUG%%
    %%FILTER_VAR%%
    %%STARTTIME%%’,’%%ENDTIME%%
    %%USERID%%
    %%WWWROOT%%

###Available filters

    %%FILTER_CATEGORIES:
    %%FILTER_COURSEMODULEID:
    %%FILTER_COURSEMODULEFIELDS:
    %%FILTER_COURSEMODULE:
    %%FILTER_COURSES:
    %%FILTER_COURSEENROLLEDSTUDENTS:
    %%FILTER_USERS:
    %%FILTER_ROLE:
    %%FILTER_SEARCHTEXT:
    %%FILTER_SEMESTER:
    %%FILTER_STARTTIME:
    %%FILTER_ENDTIME:
    %%FILTER_SUBCATEGORIES:
    %%FILTER_COURSEUSER:
    %%FILTER_SYSTEMUSER:
    %%FILTER_YEARHEBREW:
    %%FILTER_YEARNUMERIC:

##Result

In the `view report` tab, you will get the 2 filters!