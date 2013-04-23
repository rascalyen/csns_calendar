
    create table academic_standings (
        id int4 not null,
        student_id int4 not null,
        standing_id int4 not null,
        quarter int4,
        primary key (id),
        unique (student_id, standing_id)
    );

    create table advisements (
        id int4 not null,
        student_id int4 not null,
        advisor_id int4 not null,
        comment varchar(255),
        date timestamp not null,
        editable bool not null,
        edit_date timestamp,
        edited_by int4,
        for_advisor_only bool,
        emailed_to_student bool,
        primary key (id)
    );

    create table answer_sections (
        id int4 not null,
        answer_sheet_id int4 not null,
        section_index int4 not null,
        primary key (id)
    );

    create table answer_selections (
        answer_id int4 not null,
        selection int4
    );

    create table answer_sheets (
        id int4 not null,
        question_sheet_id int4 not null,
        respondent_id int4,
        timestamp timestamp,
        primary key (id)
    );

    create table answers (
        id int4 not null,
        answer_type varchar(255) not null,
        answer_section_id int4 not null,
        answer_index int4 not null,
        question_id int4,
        rating int4,
        text varchar(255),
        attachment int4 unique,
        container_id int4,
        primary key (id)
    );

    create table assignment_templates (
        id int4 not null,
        course_id int4,
        name varchar(255) not null,
        short_name varchar(255) not null,
        total_points varchar(255),
        allowed_max_file_size int8,
        allowed_file_extensions varchar(255),
        description varchar(255),
        online bool not null,
        creator_id int4,
        date timestamp,
        primary key (id),
        unique (course_id, name)
    );

    create table assignments (
        id int4 not null,
        assignment_type varchar(255) not null,
        name varchar(255) not null,
        short_name varchar(255) not null,
        total_points varchar(255),
        section_id int4,
        due_date timestamp,
        allowed_max_file_size int8,
        allowed_file_extensions varchar(255),
        question_sheet_id int4 unique,
        viewable_after_close bool not null,
        primary key (id)
    );

    create table authorities (
        user_id int4 not null,
        role_id int4 not null,
        primary key (user_id, role_id)
    );

    create table concentration_courses (
        concentration_id int4 not null,
        course_id int4 not null,
        primary key (concentration_id, course_id)
    );

    create table concentrations (
        id int4 not null,
        name varchar(255),
        program_id int4,
        required_units int4,
        primary key (id)
    );

    create table course_journal_assignments (
        course_journal_id int4 not null,
        file_id int4 not null,
        assignment_order int4 not null,
        primary key (course_journal_id, assignment_order)
    );

    create table course_journal_enrollment_samples (
        course_journal_id int4 not null,
        enrollment_id int4 not null,
        primary key (course_journal_id, enrollment_id)
    );

    create table course_journal_handouts (
        course_journal_id int4 not null,
        file_id int4 not null,
        handout_order int4 not null,
        primary key (course_journal_id, handout_order)
    );

    create table course_journals (
        id int4 not null,
        section_id int4 not null unique,
        syllabus int4 unique,
        submit_date timestamp,
        approve_date timestamp,
        primary key (id)
    );

    create table course_prerequisites (
        course_id int4 not null,
        prerequisite_id int4 not null,
        primary key (course_id, prerequisite_id)
    );

    create table course_substitutions (
        id int4 not null,
        orginal_course_id int4,
        substitue_course_id int4,
        advisement_id int4,
        primary key (id)
    );

    create table course_transfers (
        id int4 not null,
        course_id int4,
        advisement_id int4,
        primary key (id)
    );

    create table course_waivers (
        id int4 not null,
        course_id int4,
        advisement_id int4,
        primary key (id)
    );

    create table courses (
        id int4 not null,
        code varchar(255) not null,
        name varchar(255) not null,
        units int4 not null,
        description int4 unique,
        coordinator_id int4,
        is_graduate_course bool not null,
        auto_create_assignments bool not null,
        obsolete bool not null,
        primary key (id)
    );

    create table enrollments (
        id int4 not null,
        section_id int4 not null,
        student_id int4 not null,
        grade int4,
        comments varchar(255),
        grade_mailed bool not null,
        primary key (id),
        unique (section_id, student_id)
    );

    create table events (
        id int4 not null,
        title varchar(255) not null,
        description varchar(255),
        startTime timestamp not null,
        endTime timestamp not null,
        open bool not null,
        section_id int4,
        creator_id int4 not null,
        primary key (id)
    );

    create table events_files (
        event_id int4 not null,
        file_id int4 not null,
        primary key (event_id, file_id)
    );

    create table files (
        id int4 not null,
        name varchar(255) not null,
        version int4 not null,
        type varchar(255),
        size int8,
        date timestamp not null,
        owner_id int4 not null,
        parent_id int4,
        folder bool not null,
        public bool not null,
        section_id int4,
        regular bool not null,
        deleted bool not null,
        primary key (id)
    );

    create table forum_favorites (
        user_id int4 not null,
        forum_id int4 not null,
        primary key (user_id, forum_id)
    );

    create table forum_moderators (
        forum_id int4 not null,
        user_id int4 not null,
        primary key (forum_id, user_id)
    );

    create table forum_post_attachments (
        forum_post_id int4 not null,
        file_id int4 not null unique,
        primary key (forum_post_id, file_id)
    );

    create table forum_posts (
        id int4 not null,
        subject varchar(255),
        content varchar(255),
        date timestamp,
        author_id int4 not null,
        topic_id int4,
        edited_by int4,
        edit_date timestamp,
        primary key (id)
    );

    create table forum_topics (
        id int4 not null,
        pinned bool not null,
        num_of_views int4 not null,
        first_post_id int4,
        last_post_id int4,
        forum_id int4,
        notification_enabled bool not null,
        deleted bool not null,
        primary key (id)
    );

    create table forums (
        id int4 not null,
        name varchar(255) not null unique,
        description varchar(255),
        date timestamp,
        owner_id int4,
        num_of_topics int4 not null,
        num_of_posts int4 not null,
        last_post_id int4 unique,
        course_id int4 unique,
        notification_enabled bool not null,
        primary key (id)
    );

    create table generated_cins (
        id int4 not null,
        primary key (id)
    );

    create table grades (
        id int4 not null,
        symbol varchar(255) not null unique,
        value float8,
        description varchar(255),
        primary key (id)
    );

    create table instructors (
        section_id int4 not null,
        instructor_id int4 not null,
        instructor_order int4 not null,
        primary key (section_id, instructor_order)
    );

    create table log_events (
        id int4 not null,
        url varchar(255),
        session varchar(255),
        event varchar(255),
        details varchar(255),
        timestamp timestamp,
        primary key (id)
    );

    create table log_request_parameters (
        request_id int4 not null,
        param_value varchar(255),
        param_name varchar(255) not null,
        primary key (request_id, param_name)
    );

    create table log_requests (
        id int4 not null,
        uri varchar(255),
        method varchar(255),
        protocol varchar(255),
        username varchar(255),
        address varchar(255),
        browser varchar(255),
        session varchar(255),
        timestamp timestamp,
        primary key (id)
    );

    create table mailinglist_message_attachments (
        mailinglist_message_id int4 not null,
        file_id int4 not null unique,
        primary key (mailinglist_message_id, file_id)
    );

    create table mailinglist_messages (
        id int4 not null,
        subject varchar(255),
        content varchar(255),
        date timestamp,
        author_id int4 not null,
        mailinglist_id int4,
        primary key (id)
    );

    create table mailinglists (
        id int4 not null,
        name varchar(255) not null unique,
        description varchar(255),
        date timestamp not null,
        owner_id int4 not null,
        primary key (id)
    );

    create table mft_assessment_summaries (
        id int4 not null,
        date timestamp not null unique,
        ai1 int4,
        ai2 int4,
        ai3 int4,
        deleted bool not null,
        primary key (id)
    );

    create table mft_distribution_types (
        id int4 not null,
        name varchar(255) not null,
        alias varchar(255) not null unique,
        min int4 not null,
        max int4 not null,
        value_label varchar(255),
        primary key (id)
    );

    create table mft_distributions (
        id int4 not null,
        type_id int4,
        from_date timestamp,
        to_date timestamp,
        num_of_samples int4,
        mean float8,
        median float8,
        stdev float8,
        p5 int4,
        p10 int4,
        p15 int4,
        p20 int4,
        p25 int4,
        p30 int4,
        p35 int4,
        p40 int4,
        p45 int4,
        p50 int4,
        p55 int4,
        p60 int4,
        p65 int4,
        p70 int4,
        p75 int4,
        p80 int4,
        p85 int4,
        p90 int4,
        p95 int4,
        deleted bool not null,
        primary key (id)
    );

    create table news (
        id int4 not null,
        topic_id int4 not null unique,
        expire_date timestamp,
        primary key (id)
    );

    create table prerequisite_courses (
        prerequisite_id int4 not null,
        course_id int4 not null,
        primary key (prerequisite_id, course_id)
    );

    create table prerequisites (
        id int4 not null,
        name varchar(255),
        primary key (id)
    );

    create table program_core_courses (
        program_id int4 not null,
        course_id int4 not null,
        primary key (program_id, course_id)
    );

    create table program_course_substitutions (
        program_id int4 not null,
        course_substitution_id int4 not null,
        primary key (program_id, course_substitution_id)
    );

    create table program_elective_courses (
        program_id int4 not null,
        course_id int4 not null,
        primary key (program_id, course_id)
    );

    create table program_limited_elective_courses (
        program_id int4 not null,
        course_id int4 not null,
        primary key (program_id, course_id)
    );

    create table program_other_courses (
        program_id int4 not null,
        course_id int4 not null,
        primary key (program_id, course_id)
    );

    create table program_prereq_courses (
        program_id int4 not null,
        course_id int4 not null,
        primary key (program_id, course_id)
    );

    create table programs (
        id int4 not null,
        type varchar(255) not null,
        name varchar(255) not null,
        effective_date timestamp,
        obsolete bool not null,
        total_elective_units int4 not null,
        limited_elective_units int4 not null,
        primary key (id)
    );

    create table question_choices (
        question_id int4 not null,
        choice varchar(255),
        choice_index int4 not null,
        primary key (question_id, choice_index)
    );

    create table question_correct_selections (
        question_id int4 not null,
        selection int4
    );

    create table question_sections (
        id int4 not null,
        description varchar(255),
        question_sheet_id int4,
        section_index int4,
        primary key (id)
    );

    create table question_sheets (
        id int4 not null,
        name varchar(255) not null,
        description varchar(255),
        creator_id int4 not null,
        create_date timestamp not null,
        publish_date timestamp,
        close_date timestamp,
        primary key (id)
    );

    create table questions (
        id int4 not null,
        question_type varchar(255) not null,
        description varchar(255),
        point_value int4,
        min_selections int4,
        max_selections int4,
        min_rating int4,
        max_rating int4,
        correct_answer varchar(255),
        text_length int4,
        attachment_allowed bool not null,
        container_id int4,
        question_index int4,
        question_section_id int4,
        primary key (id)
    );

    create table roles (
        id int4 not null,
        name varchar(255) not null unique,
        description varchar(255),
        regular bool not null,
        can_be_primary bool not null,
        primary key (id)
    );

    create table sections (
        id int4 not null,
        quarter int4 not null,
        course_id int4 not null,
        number int4 not null,
        primary key (id),
        unique (quarter, course_id, number)
    );

    create table skill_evaluations (
        id int4 not null,
        section_id int4,
        student_id int4 not null,
        skill_id int4 not null,
        value int4,
        removed bool not null,
        primary key (id),
        unique (section_id, student_id, skill_id)
    );

    create table skills (
        id int4 not null,
        name varchar(255) not null unique,
        description varchar(255),
        primary key (id)
    );

    create table skillsets (
        course_id int4 not null,
        skill_id int4 not null,
        primary key (course_id, skill_id)
    );

    create table standings (
        id int4 not null,
        symbol varchar(255) not null unique,
        name varchar(255),
        description varchar(255),
        primary key (id)
    );

    create table stored_queries (
        id int4 not null,
        name varchar(255) not null unique,
        query varchar(255) not null,
        date timestamp,
        author_id int4,
        chart_title varchar(255),
        chart_x_axis_label varchar(255),
        chart_y_axis_label varchar(255),
        transpose_results bool not null,
        enabled bool not null,
        deleted bool not null,
        primary key (id)
    );

    create table submission_files (
        submission_id int4 not null,
        file_id int4 not null unique,
        primary key (submission_id, file_id)
    );

    create table submissions (
        id int4 not null,
        submission_type varchar(255) not null,
        student_id int4 not null,
        assignment_id int4 not null,
        grade varchar(255),
        comments text,
        notes varchar(255),
        grade_mailed bool not null,
        answer_sheet_id int4 unique,
        primary key (id),
        unique (student_id, assignment_id)
    );

    create table subscriptions (
        id int4 not null,
        subscribable_id int4 not null,
        subscriber_id int4 not null,
        subscription_type int4 not null,
        date timestamp not null,
        status int4 not null,
        primary key (id),
        unique (subscribable_id, subscriber_id)
    );

    create table survey_responses (
        id int4 not null,
        survey_id int4 not null,
        answer_sheet_id int4 not null unique,
        primary key (id)
    );

    create table surveys (
        id int4 not null,
        name varchar(255) not null unique,
        survey_type int4 not null,
        enabled bool not null,
        question_sheet_id int4 not null unique,
        primary key (id)
    );

    create table surveys_taken (
        user_id int4 not null,
        survey_id int4 not null,
        primary key (user_id, survey_id)
    );

    create table tasks (
        id int4 not null,
        title varchar(255) not null,
        completed_date timestamp,
        creator_id int4 not null,
        primary key (id)
    );

    create table users (
        id int4 not null,
        username varchar(255) not null unique,
        password varchar(255) not null,
        enabled bool not null,
        date_created timestamp not null,
        primary_role int4 not null,
        cin varchar(255) not null unique,
        cin_encrypted bool not null,
        last_name varchar(255) not null,
        first_name varchar(255) not null,
        middle_name varchar(255),
        email varchar(255) not null unique,
        email2 varchar(255) unique,
        address1 varchar(255),
        address2 varchar(255),
        city varchar(255),
        state varchar(255),
        zip varchar(255),
        phone varchar(255),
        phone2 varchar(255),
        birthday timestamp,
        gender varchar(255),
        mft_score int4,
        mft_date timestamp,
        current_standing_id int4 unique,
        show_favorite_forums bool not null,
        num_of_forum_posts int4 not null,
        disk_quota int4 not null,
        primary key (id)
    );

    create table wiki_discussions (
        page_id int4 not null,
        topic_id int4 not null unique,
        primary key (page_id, topic_id)
    );

    create table wiki_pages (
        id int4 not null,
        path varchar(255) not null unique,
        owner_id int4 not null,
        password varchar(255),
        locked bool not null,
        primary key (id)
    );

    create table wiki_revisions (
        id int4 not null,
        subject varchar(255),
        content varchar(255),
        date timestamp,
        author_id int4 not null,
        page_id int4,
        include_sidebar bool not null,
        primary key (id)
    );

    alter table academic_standings 
        add constraint FKC635A86F1CA7E058 
        foreign key (standing_id) 
        references standings;

    alter table academic_standings 
        add constraint FKC635A86F25DC8E88 
        foreign key (student_id) 
        references users;

    alter table advisements 
        add constraint FK403428ED25DC8E88 
        foreign key (student_id) 
        references users;

    alter table advisements 
        add constraint FK403428ED3CBD06E3 
        foreign key (advisor_id) 
        references users;

    alter table advisements 
        add constraint FK403428EDF47A0116 
        foreign key (edited_by) 
        references users;

    alter table answer_sections 
        add constraint FK96B4258F9AA31C1D 
        foreign key (answer_sheet_id) 
        references answer_sheets;

    alter table answer_selections 
        add constraint FK3DB533885DC9F17B 
        foreign key (answer_id) 
        references answers;

    alter table answer_sheets 
        add constraint FK4BB67A95AEAD46AD 
        foreign key (respondent_id) 
        references users;

    alter table answer_sheets 
        add constraint FK4BB67A95810289CD 
        foreign key (question_sheet_id) 
        references question_sheets;

    alter table answers 
        add constraint FKCD7DB875225139B8 
        foreign key (container_id) 
        references answers;

    alter table answers 
        add constraint FKCD7DB875F424C19D 
        foreign key (answer_section_id) 
        references answer_sections;

    alter table answers 
        add constraint FKCD7DB875EE566FBD 
        foreign key (attachment) 
        references files;

    alter table answers 
        add constraint FKCD7DB8752E9C937A 
        foreign key (question_id) 
        references questions;

    alter table assignment_templates 
        add constraint FK117EE847B59CFEF7 
        foreign key (creator_id) 
        references users;

    alter table assignment_templates 
        add constraint FK117EE8475A8D0978 
        foreign key (course_id) 
        references courses;

    alter table assignments 
        add constraint FK68455346B8CFADBC 
        foreign key (section_id) 
        references sections;

    alter table assignments 
        add constraint FK68455346810289CD 
        foreign key (question_sheet_id) 
        references question_sheets;

    alter table authorities 
        add constraint FK2B0F1321B5763718 
        foreign key (role_id) 
        references roles;

    alter table authorities 
        add constraint FK2B0F13215AA0FAF8 
        foreign key (user_id) 
        references users;

    alter table concentration_courses 
        add constraint FK12AF71E6629BF3C 
        foreign key (concentration_id) 
        references concentrations;

    alter table concentration_courses 
        add constraint FK12AF71E65A8D0978 
        foreign key (course_id) 
        references courses;

    alter table concentrations 
        add constraint FK96529A618FF955C 
        foreign key (program_id) 
        references programs;

    alter table course_journal_assignments 
        add constraint FK6271981A3068D158 
        foreign key (file_id) 
        references files;

    alter table course_journal_assignments 
        add constraint FK6271981A9A5D5415 
        foreign key (course_journal_id) 
        references course_journals;

    alter table course_journal_enrollment_samples 
        add constraint FK2596A7A25B1B5D8 
        foreign key (enrollment_id) 
        references enrollments;

    alter table course_journal_enrollment_samples 
        add constraint FK2596A7A9A5D5415 
        foreign key (course_journal_id) 
        references course_journals;

    alter table course_journal_handouts 
        add constraint FK680337803068D158 
        foreign key (file_id) 
        references files;

    alter table course_journal_handouts 
        add constraint FK680337809A5D5415 
        foreign key (course_journal_id) 
        references course_journals;

    alter table course_journals 
        add constraint FK284E77C0CCC3247F 
        foreign key (syllabus) 
        references files;

    alter table course_journals 
        add constraint FK284E77C0B8CFADBC 
        foreign key (section_id) 
        references sections;

    alter table course_prerequisites 
        add constraint FKA9DADB595A8D0978 
        foreign key (course_id) 
        references courses;

    alter table course_prerequisites 
        add constraint FKA9DADB596A41118 
        foreign key (prerequisite_id) 
        references prerequisites;

    alter table course_substitutions 
        add constraint FK12AF43F2C1229698 
        foreign key (advisement_id) 
        references advisements;

    alter table course_substitutions 
        add constraint FK12AF43F222BFD215 
        foreign key (substitue_course_id) 
        references courses;

    alter table course_substitutions 
        add constraint FK12AF43F270C163ED 
        foreign key (orginal_course_id) 
        references courses;

    alter table course_transfers 
        add constraint FKBB48FAC4C1229698 
        foreign key (advisement_id) 
        references advisements;

    alter table course_transfers 
        add constraint FKBB48FAC45A8D0978 
        foreign key (course_id) 
        references courses;

    alter table course_waivers 
        add constraint FKA0B4AC6BC1229698 
        foreign key (advisement_id) 
        references advisements;

    alter table course_waivers 
        add constraint FKA0B4AC6B5A8D0978 
        foreign key (course_id) 
        references courses;

    alter table courses 
        add constraint FK391923B881DC3573 
        foreign key (coordinator_id) 
        references users;

    alter table courses 
        add constraint FK391923B8FC949A96 
        foreign key (description) 
        references files;

    alter table enrollments 
        add constraint FKD680FDEF25DC8E88 
        foreign key (student_id) 
        references users;

    alter table enrollments 
        add constraint FKD680FDEFE768250 
        foreign key (grade) 
        references grades;

    alter table enrollments 
        add constraint FKD680FDEFB8CFADBC 
        foreign key (section_id) 
        references sections;

    alter table events 
        add constraint FKB307E119B59CFEF7 
        foreign key (creator_id) 
        references users;

    alter table events 
        add constraint FKB307E119B8CFADBC 
        foreign key (section_id) 
        references sections;

    alter table events_files 
        add constraint FK3E4207D13068D158 
        foreign key (file_id) 
        references files;

    alter table events_files 
        add constraint FK3E4207D183CF4C28 
        foreign key (event_id) 
        references events;

    alter table files 
        add constraint FK5CEBA77B8CFADBC 
        foreign key (section_id) 
        references sections;

    alter table files 
        add constraint FK5CEBA77DEC5C76A 
        foreign key (parent_id) 
        references files;

    alter table files 
        add constraint FK5CEBA77C687AB10 
        foreign key (owner_id) 
        references users;

    alter table forum_favorites 
        add constraint FK1958BCB95AA0FAF8 
        foreign key (user_id) 
        references users;

    alter table forum_favorites 
        add constraint FK1958BCB9FE5A182F 
        foreign key (forum_id) 
        references forums;

    alter table forum_moderators 
        add constraint FK7C3AF5EC5AA0FAF8 
        foreign key (user_id) 
        references users;

    alter table forum_moderators 
        add constraint FK7C3AF5ECFE5A182F 
        foreign key (forum_id) 
        references forums;

    alter table forum_post_attachments 
        add constraint FKB4866DEF3068D158 
        foreign key (file_id) 
        references files;

    alter table forum_post_attachments 
        add constraint FKB4866DEF20DD53E7 
        foreign key (forum_post_id) 
        references forum_posts;

    alter table forum_posts 
        add constraint FKEDDC4F35BB59ED38 
        foreign key (author_id) 
        references users;

    alter table forum_posts 
        add constraint FKEDDC4F35A958756F 
        foreign key (topic_id) 
        references forum_topics;

    alter table forum_posts 
        add constraint FKEDDC4F35F47A0116 
        foreign key (edited_by) 
        references users;

    alter table forum_topics 
        add constraint FKD47F7202FE5A182F 
        foreign key (forum_id) 
        references forums;

    alter table forum_topics 
        add constraint FKD47F720217FF9A76 
        foreign key (first_post_id) 
        references forum_posts;

    alter table forum_topics 
        add constraint FKD47F720243B0145C 
        foreign key (last_post_id) 
        references forum_posts;

    alter table forums 
        add constraint FKB46017725A8D0978 
        foreign key (course_id) 
        references courses;

    alter table forums 
        add constraint FKB4601772C687AB10 
        foreign key (owner_id) 
        references users;

    alter table forums 
        add constraint FKB460177243B0145C 
        foreign key (last_post_id) 
        references forum_posts;

    alter table instructors 
        add constraint FK11F90376DB2BCCE6 
        foreign key (instructor_id) 
        references users;

    alter table instructors 
        add constraint FK11F90376B8CFADBC 
        foreign key (section_id) 
        references sections;

    alter table log_request_parameters 
        add constraint FKD3CBFA75EA9DC19B 
        foreign key (request_id) 
        references log_requests;

    alter table mailinglist_message_attachments 
        add constraint FK6BDFCC223068D158 
        foreign key (file_id) 
        references files;

    alter table mailinglist_message_attachments 
        add constraint FK6BDFCC227FF9008D 
        foreign key (mailinglist_message_id) 
        references mailinglist_messages;

    alter table mailinglist_messages 
        add constraint FK7B4FD2E2BA7D82B7 
        foreign key (mailinglist_id) 
        references mailinglists;

    alter table mailinglist_messages 
        add constraint FK7B4FD2E2BB59ED38 
        foreign key (author_id) 
        references users;

    alter table mailinglists 
        add constraint FK7C78C7AAC687AB10 
        foreign key (owner_id) 
        references users;

    alter table mft_distributions 
        add constraint FK586D672BFB70BA6B 
        foreign key (type_id) 
        references mft_distribution_types;

    alter table news 
        add constraint FK338AD3A958756F 
        foreign key (topic_id) 
        references forum_topics;

    alter table prerequisite_courses 
        add constraint FK98EC172F5A8D0978 
        foreign key (course_id) 
        references courses;

    alter table prerequisite_courses 
        add constraint FK98EC172F6A41118 
        foreign key (prerequisite_id) 
        references prerequisites;

    alter table program_core_courses 
        add constraint FK5FA66CF318FF955C 
        foreign key (program_id) 
        references programs;

    alter table program_core_courses 
        add constraint FK5FA66CF35A8D0978 
        foreign key (course_id) 
        references courses;

    alter table program_course_substitutions 
        add constraint FK3A163ACD7E138CCF 
        foreign key (course_substitution_id) 
        references course_substitutions;

    alter table program_course_substitutions 
        add constraint FK3A163ACD18FF955C 
        foreign key (program_id) 
        references programs;

    alter table program_elective_courses 
        add constraint FK122B02BD18FF955C 
        foreign key (program_id) 
        references programs;

    alter table program_elective_courses 
        add constraint FK122B02BD5A8D0978 
        foreign key (course_id) 
        references courses;

    alter table program_limited_elective_courses 
        add constraint FK4A632BC218FF955C 
        foreign key (program_id) 
        references programs;

    alter table program_limited_elective_courses 
        add constraint FK4A632BC25A8D0978 
        foreign key (course_id) 
        references courses;

    alter table program_other_courses 
        add constraint FKF586730E18FF955C 
        foreign key (program_id) 
        references programs;

    alter table program_other_courses 
        add constraint FKF586730E5A8D0978 
        foreign key (course_id) 
        references courses;

    alter table program_prereq_courses 
        add constraint FK195A55AF18FF955C 
        foreign key (program_id) 
        references programs;

    alter table program_prereq_courses 
        add constraint FK195A55AF5A8D0978 
        foreign key (course_id) 
        references courses;

    alter table question_choices 
        add constraint FKCCF0F399376C843B 
        foreign key (question_id) 
        references questions;

    alter table question_correct_selections 
        add constraint FKC4E1AC55376C843B 
        foreign key (question_id) 
        references questions;

    alter table question_sections 
        add constraint FK9CB15667810289CD 
        foreign key (question_sheet_id) 
        references question_sheets;

    alter table question_sheets 
        add constraint FK747A016DB59CFEF7 
        foreign key (creator_id) 
        references users;

    alter table questions 
        add constraint FK95C5414DF7DEA1A0 
        foreign key (container_id) 
        references questions;

    alter table questions 
        add constraint FK95C5414DC05F834D 
        foreign key (question_section_id) 
        references question_sections;

    alter table sections 
        add constraint FK38805E2E5A8D0978 
        foreign key (course_id) 
        references courses;

    alter table skill_evaluations 
        add constraint FK555E17C9CC1DBDCC 
        foreign key (skill_id) 
        references skills;

    alter table skill_evaluations 
        add constraint FK555E17C925DC8E88 
        foreign key (student_id) 
        references users;

    alter table skill_evaluations 
        add constraint FK555E17C9B8CFADBC 
        foreign key (section_id) 
        references sections;

    alter table skillsets 
        add constraint FK76BD0A22CC1DBDCC 
        foreign key (skill_id) 
        references skills;

    alter table skillsets 
        add constraint FK76BD0A225A8D0978 
        foreign key (course_id) 
        references courses;

    alter table stored_queries 
        add constraint FK2D2F4ECABB59ED38 
        foreign key (author_id) 
        references users;

    alter table submission_files 
        add constraint FK6FA2AFC43068D158 
        foreign key (file_id) 
        references files;

    alter table submission_files 
        add constraint FK6FA2AFC4D9F46EDD 
        foreign key (submission_id) 
        references submissions;

    alter table submissions 
        add constraint FK2912EA75C27333D 
        foreign key (assignment_id) 
        references assignments;

    alter table submissions 
        add constraint FK2912EA725DC8E88 
        foreign key (student_id) 
        references users;

    alter table submissions 
        add constraint FK2912EA79AA31C1D 
        foreign key (answer_sheet_id) 
        references answer_sheets;

    alter table subscriptions 
        add constraint FK7674CAF6C127793B 
        foreign key (subscriber_id) 
        references users;

    alter table survey_responses 
        add constraint FK86922DAD5B66DD70 
        foreign key (survey_id) 
        references surveys;

    alter table survey_responses 
        add constraint FK86922DAD9AA31C1D 
        foreign key (answer_sheet_id) 
        references answer_sheets;

    alter table surveys 
        add constraint FK91914459810289CD 
        foreign key (question_sheet_id) 
        references question_sheets;

    alter table surveys_taken 
        add constraint FK95459D615AA0FAF8 
        foreign key (user_id) 
        references users;

    alter table surveys_taken 
        add constraint FK95459D615B66DD70 
        foreign key (survey_id) 
        references surveys;

    alter table tasks 
        add constraint FK6907B8EB59CFEF7 
        foreign key (creator_id) 
        references users;

    alter table users 
        add constraint FK6A68E0822BBBAB9 
        foreign key (current_standing_id) 
        references academic_standings;

    alter table users 
        add constraint FK6A68E0820FA3E27 
        foreign key (primary_role) 
        references roles;

    alter table wiki_discussions 
        add constraint FKE66DD33CA958756F 
        foreign key (topic_id) 
        references forum_topics;

    alter table wiki_discussions 
        add constraint FKE66DD33C773840BA 
        foreign key (page_id) 
        references wiki_pages;

    alter table wiki_pages 
        add constraint FK24357E75C687AB10 
        foreign key (owner_id) 
        references users;

    alter table wiki_revisions 
        add constraint FKE0471229BB59ED38 
        foreign key (author_id) 
        references users;

    alter table wiki_revisions 
        add constraint FKE0471229773840BA 
        foreign key (page_id) 
        references wiki_pages;

    create sequence hibernate_sequence;
