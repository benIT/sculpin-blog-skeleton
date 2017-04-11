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

##Result

In the `view report` tab, you will get the 2 filters!