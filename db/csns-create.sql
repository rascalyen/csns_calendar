set client_min_messages=WARNING;

create sequence hibernate_sequence minvalue 2000000;

create table generated_cins ( id integer primary key );

---------------------
-- users and roles --
---------------------

create table roles (
    id              integer primary key,
    name            varchar(255) not null unique,
    description     varchar(4092),
    regular         boolean not null default 'f',
    can_be_primary  boolean not null default 'f'
);

create table users (
    id                      integer primary key,
    username                varchar(255) not null unique,
    password                varchar(255) not null,
    enabled                 boolean not null,
    date_created            timestamp not null,
    primary_role            integer not null references roles(id),
    cin                     varchar(255) not null unique,
    cin_encrypted           boolean not null,
    last_name               varchar(255) not null,
    first_name              varchar(255) not null,
    middle_name             varchar(255),
    email                   varchar(255) not null unique,
    email2                  varchar(255),
    address1                varchar(255),
    address2                varchar(255),
    city                    varchar(255),
    state                   varchar(255),
    zip                     varchar(255),
    phone                   varchar(255),
    phone2                  varchar(255),
    birthday                date,
    gender                  char(1) check( gender = 'M' or gender = 'F' ),
    mft_score               integer,
    mft_date                timestamp,
    current_standing_id     integer,
    show_favorite_forums    boolean not null default 't',
    num_of_forum_posts      integer not null default 0,
    disk_quota              integer not null default 100,
    event_id                integer,
    recipient_order         integer
);

create index user_names_index on users ( lower(last_name||first_name) );
create index user_firstname_index on users ( lower(first_name) );
create index user_lastname_index on users ( lower(last_name) );
create index user_fullname_index on users ( lower(first_name || ' ' || last_name) );
create index user_username_index on users ( lower(username) );

create table authorities (
    user_id     integer not null references users(id),
    role_id     integer not null references roles(id),
  primary key (user_id, role_id)
);

-----------
-- files --
-----------

create table files (
    id          integer primary key,
    name        varchar(255) not null,
    version     integer not null,
    type        varchar(255),
    size        bigint,
    date        timestamp,
    folder      boolean not null default 'f',
    public      boolean not null default 'f',
    section_id  integer,
    regular     boolean not null default 'f',
    deleted     boolean not null default 'f',
    parent_id   integer references files(id),
    owner_id    integer not null references users(id),
);

------------
-- grades --
------------

create table grades (
    id          integer primary key,
    symbol      varchar(255) not null unique,
    value       real,
    description varchar(1022)
);

-----------------------------------------
-- courses, sections, and encrollments --
-----------------------------------------

create table courses (
    id                      integer primary key,
    code                    varchar(255) not null,
    name                    varchar(255) not null,
    units                   integer not null default 4,
    description             integer unique references files(id),
    coordinator_id          integer references users(id),
    is_graduate_course      boolean not null default 'f',
    auto_create_assignments boolean not null default 'f',
    obsolete                boolean not null default 'f'
);

create table prerequisites (
    id      integer primary key,
    name    varchar(255)
);

create table prerequisite_courses (
    prerequisite_id integer not null references prerequisites(id),
    course_id       integer not null references courses(id),
  primary key (prerequisite_id, course_id)
);

create table course_prerequisites (
    course_id       integer not null references courses(id),
    prerequisite_id integer not null references prerequisites(id),
  primary key (course_id, prerequisite_id)
);

create table sections (
    id              integer primary key,
    quarter         integer not null,
    course_id       integer not null references courses(id),
    number          integer not null,
  unique (quarter, course_id, number)
);

create table instructors (
    section_id          integer not null references sections(id),
    instructor_id       integer not null references users(id),
    instructor_order    integer not null,
  primary key (section_id, instructor_order)
);

create table enrollments (
    id              integer primary key,
    section_id      integer not null references sections(id),
    student_id      integer not null references users(id),
    grade           integer references grades(id),
    comments        text,
    grade_mailed    boolean not null default 'f',
  unique (section_id, student_id)
);

alter table files add constraint files_section_id_fkey
    foreign key (section_id) references sections(id);

-----------------
-- advisements --
-----------------

create table advisements (
    id                  integer primary key,
    student_id          integer not null references users(id),
    advisor_id          integer not null references users(id),
    comments            varchar(8000),
    date                timestamp not null default current_timestamp,
    editable            bool not null default 't',
    edit_date           timestamp,
    edited_by           integer references users(id),
    for_advisor_only    boolean default 'f',
    emailed_to_student  boolean default 'f'
);

create table course_substitutions (
    id                  integer primary key,
    orginal_course_id   integer references courses(id),
    substitue_course_id integer references courses(id),
    advisement_id       integer references advisements(id)
);

create table course_transfers (
    id              integer primary key,
    course_id       integer references courses(id),
    advisement_id   integer references advisements(id)
);

create table course_waivers (
    id              integer primary key,
    course_id       integer references courses(id),
    advisement_id   integer references advisements(id)
);

--------------
-- programs --
--------------

create table programs (
    id                      integer primary key,
    type                    varchar(255) not null,
    name                    varchar(255) not null,
    effective_date          date,
    obsolete                boolean not null default 'f',
    total_elective_units    integer not null default 0,
    limited_elective_units  integer not null default 0
);

create table program_prereq_courses (
    program_id  integer not null references programs(id),
    course_id   integer not null references courses(id),
  primary key (program_id, course_id)
);

create table program_core_courses (
    program_id  integer not null references programs(id),
    course_id   integer not null references courses(id),
  primary key (program_id, course_id)
);

create table program_other_courses (
    program_id  integer not null references programs(id),
    course_id   integer not null references courses(id),
  primary key (program_id, course_id)
);

create table program_elective_courses (
    program_id  integer not null references programs(id),
    course_id   integer not null references courses(id),
  primary key (program_id, course_id)
);

create table program_limited_elective_courses (
    program_id  integer not null references programs(id),
    course_id   integer not null references programs(id),
  primary key (program_id, course_id)
);

create table program_course_substitutions (
    program_id              integer not null references programs(id),
    course_substitution_id  integer not null references course_substitutions(id),
  primary key (program_id, course_substitution_id)
);

create table concentrations (
    id              integer primary key,
    name            varchar(255),
    program_id      integer references programs(id),
    required_units  integer
);

create table concentration_courses (
    concentration_id    integer not null references concentrations(id),
    course_id           integer not null references courses(id),
  primary key (concentration_id, course_id)
);

---------------
-- standings --
---------------

create table standings (
    id          integer primary key,
    symbol      varchar(255) not null unique,
    name        varchar(255),
    description varchar(8000)
);

create table academic_standings (
    id          integer primary key,
    student_id  integer not null references users(id),
    standing_id integer not null references standings(id),
    quarter     integer,
  unique (student_id, standing_id)
);

alter table users add constraint users_current_standing_id_fkey
    foreign key (current_standing_id) references academic_standings(id);

--------------------------
-- question and answers --
--------------------------

create table question_sheets (
    id              integer primary key,
    name            varchar(255) not null,
    description     varchar(4092),
    creator_id      integer not null references users(id),
    create_date     timestamp not null default current_timestamp,
    publish_date    timestamp,
    close_date      timestamp
);

create table question_sections (
    id                  integer primary key,
    description         varchar(4092),
    question_sheet_id   integer references question_sheets(id),
    section_index       integer,
  unique (question_sheet_id, section_index)
);

create table questions (
    id                  integer primary key,
    question_type       varchar(255) not null,
    description         varchar(4092),
    point_value         integer,
    min_selections      integer,
    max_selections      integer,
    min_rating          integer,
    max_rating          integer,
    text_length         integer,
    attachment_allowed  boolean not null default 'f',
    correct_answer      varchar(8092),
    container_id        integer references questions(id),
    question_section_id integer references question_sections(id),
    question_index      integer,
  unique (question_section_id, question_index)
);

create table question_choices (
    question_id     integer not null references questions(id),
    choice          varchar(4092),
    choice_index    integer not null,
  primary key (question_id, choice_index)
);

create table question_correct_selections (
    question_id integer not null references questions(id),
    selection   integer,
  primary key (question_id, selection)
);

create table answer_sheets (
    id                  integer primary key,
    question_sheet_id   integer not null references question_sheets(id),
    respondent_id       integer references users(id),
    timestamp           timestamp
);

create table answer_sections (
    id              integer primary key,
    answer_sheet_id integer not null references answer_sheets(id),
    section_index   integer not null,
  unique (answer_sheet_id, section_index)
);

create table answers (
    id                          integer primary key,
    answer_type                 varchar(255) not null,
    answer_section_id           integer not null references answer_sections(id),
    answer_index                integer not null,
    question_id                 integer references questions(id),
    rating                      integer,
    text                        varchar(8092),
    attachment                  integer unique references files(id),
    container_id                integer references answers(id),
  unique (answer_section_id, answer_index)
);

create table answer_selections (
    answer_id   integer not null references answers(id),
    selection   integer
);

-----------------
-- assignments --
-----------------

create table assignments (
    id                      integer primary key,
    assignment_type         varchar(255) not null default 'REGULAR',
    name                    varchar(255) not null,
    short_name              varchar(255) not null,
    total_points            varchar(255),
    section_id              integer references sections(id),
    due_date                timestamp,
    allowed_max_file_size   bigint,
    allowed_file_extensions varchar(255),
    question_sheet_id       integer unique references question_sheets(id),
    viewable_after_close    boolean not null default 'f'
);

create table assignment_templates (
    id                      integer primary key,
    course_id               integer references courses(id),
    name                    varchar(255) not null,
    short_name              varchar(255) not null,
    total_points            varchar(255),
    allowed_max_file_size   bigint,
    allowed_file_extensions varchar(255),
    description             varchar(4000),
    online                  boolean not null default 'f',
    creator_id              integer references users(id),
    date                    timestamp default current_timestamp,
  unique (course_id, name)
);

create table submissions (
    id              integer primary key,
    submission_type varchar(255) not null default 'REGULAR',
    student_id      integer not null references users(id),
    assignment_id   integer not null references assignments(id),
    grade           varchar(255),
    comments        text,
    notes           varchar(8000),
    grade_mailed    boolean not null default 'f',
    answer_sheet_id integer unique references answer_sheets(id),
  unique (student_id, assignment_id)
);

create table submission_files (
    submission_id   integer not null references submissions(id),
    file_id         integer not null unique references files(id),
  primary key (submission_id, file_id)
);

----------------
-- assessment --
----------------

create table course_journals (
    id              integer primary key,
    section_id      integer not null unique references sections(id),
    syllabus        integer unique references files(id),
    submit_date     timestamp,
    approve_date    timestamp
);

create table course_journal_handouts (
    course_journal_id   integer not null references course_journals(id),
    file_id             integer not null references files(id),
    handout_order       integer not null,
  primary key (course_journal_id, handout_order)
);

create table course_journal_assignments (
    course_journal_id   integer not null references course_journals(id),
    file_id             integer not null references files(id),
    assignment_order    integer not null,
  primary key (course_journal_id, assignment_order)
);

create table course_journal_enrollment_samples (
    course_journal_id   integer not null references course_journals(id),
    enrollment_id       integer not null references enrollments(id),
  primary key (course_journal_id, enrollment_id)
);

create table stored_queries (
    id                  integer primary key,
    name                varchar(255) not null unique,
    query               varchar(8000) not null,
    date                timestamp default current_timestamp,
    author_id           integer references users(id),
    chart_title         varchar(255),
    chart_x_axis_label  varchar(255),
    chart_y_axis_label  varchar(255),
    transpose_results   boolean not null default 'f',
    enabled             boolean not null default 'f',
    deleted             boolean not null default 'f'
);

create table skills (
    id          integer primary key,
    name        varchar(255) not null unique,
    description varchar(4000)
);

create table skillsets (
    course_id   integer not null references courses(id),
    skill_id    integer not null references skills(id),
  primary key (course_id, skill_id)
);

create table skill_evaluations (
    id          integer primary key,
    section_id  integer references sections(id),
    student_id  integer not null references users(id),
    skill_id    integer not null references skills(id),
    value       integer check( 1 <= value and value <= 5 ),
    removed     boolean not null default 'f',
  unique (section_id, student_id, skill_id)
);

create table mft_assessment_summaries (
    id      integer primary key,
    date    timestamp not null unique,
    ai1     integer,
    ai2     integer,
    ai3     integer,
    deleted boolean not null default 'f'
);

create table mft_distribution_types (
    id          integer primary key,
    name        varchar(255) not null,
    alias       varchar(255) not null unique,
    min         integer not null,
    max         integer not null,
    value_label varchar(255)
);

create table mft_distributions (
    id              integer primary key,
    type_id         integer references mft_distribution_types(id),
    from_date       timestamp,
    to_date         timestamp,
    num_of_samples  integer,
    mean            double precision,
    median          double precision,
    stdev           double precision,
    p5              integer,
    p10             integer,
    p15             integer,
    p20             integer,
    p25             integer,
    p30             integer,
    p35             integer,
    p40             integer,
    p45             integer,
    p50             integer,
    p55             integer,
    p60             integer,
    p65             integer,
    p70             integer,
    p75             integer,
    p80             integer,
    p85             integer,
    p90             integer,
    p95             integer,
    deleted         boolean not null default 'f'
);

-------------
-- surveys --
-------------

create table surveys (
    id                  integer primary key,
    name                varchar(255) not null unique,
    survey_type         integer not null default 0 check( 0 <= survey_type and survey_type <= 2 ),
    enabled             boolean not null default 't',
    question_sheet_id   integer not null unique references question_sheets(id)
);

create table survey_responses (
    id              integer primary key,
    survey_id       integer not null references surveys(id),
    answer_sheet_id integer not null unique references answer_sheets(id)
);

create table surveys_taken (
    user_id     integer not null references users(id),
    survey_id   integer not null references surveys(id),
  primary key (user_id, survey_id)
);

-------------------
-- subscriptions --
-------------------

create table subscriptions (
    id                  integer primary key,
    subscribable_id     integer not null,
    subscriber_id       integer not null references users(id),
    subscription_type   integer not null default 1,
    date                timestamp not null default current_timestamp,
    status              integer not null default 0,
  unique (subscribable_id, subscriber_id)
);

------------------
-- mailinglists --
------------------

create table mailinglists (
    id          integer primary key,
    name        varchar(255) not null unique,
    description varchar(4092),
    date        timestamp not null default current_timestamp,
    owner_id    integer not null references users(id)
);

create table mailinglist_messages (
    id              integer primary key,
    subject         varchar(255),
    content         varchar(8092),
    date            timestamp,
    author_id       integer not null references users(id),
    mailinglist_id  integer references mailinglists(id)
);

create table mailinglist_message_attachments (
    mailinglist_message_id  integer not null references mailinglist_messages(id),
    file_id                 integer not null unique references files(id),
  primary key (mailinglist_message_id, file_id)
);

alter table mailinglist_messages add column tsv tsvector;

create function mailinglist_messages_ts_trigger_function() returns trigger as $$
declare
    author users%rowtype;
begin
    select * into author from users where id = new.author_id;
    new.tsv :=
        setweight( to_tsvector('pg_catalog.english', coalesce(author.first_name,'')), 'A') ||
        setweight( to_tsvector('pg_catalog.english', coalesce(author.last_name,'')), 'A' ) ||
        setweight( to_tsvector('pg_catalog.english', coalesce(new.subject,'')), 'A') ||
        setweight( to_tsvector('pg_catalog.english', coalesce(new.content,'')), 'D' );
    return new;
end
$$ language plpgsql;

create trigger mailinglist_messages_ts_trigger
    before insert or update
    on mailinglist_messages
    for each row
    execute procedure mailinglist_messages_ts_trigger_function();

create index mailinglist_messages_ts_index
    on mailinglist_messages
    using gin(tsv);

------------
-- forums --
------------

create table forums (
    id                      integer primary key,
    name                    varchar(80) not null unique,
    description             varchar(255),
    date                    timestamp default current_timestamp,
    owner_id                integer references users(id),
    num_of_topics           integer not null default 0,
    num_of_posts            integer not null default 0,
    last_post_id            integer unique,
    course_id               integer unique references courses(id),
    notification_enabled    boolean not null default 't'
);

create table forum_moderators (
    forum_id    integer not null references forums(id),
    user_id     integer not null references users(id),
  primary key (forum_id, user_id)
);

create table forum_favorites (
    user_id     integer not null references users(id),
    forum_id    integer not null references forums(id),
  primary key (user_id, forum_id)
);

create table forum_topics (
    id                      integer primary key,
    pinned                  boolean not null default 'f',
    num_of_views            integer not null default 0,
    first_post_id           integer,
    last_post_id            integer,
    forum_id                integer not null references forums(id),
    notification_enabled    boolean not null default 't',
    deleted                 boolean not null default 'f'
);

create table forum_posts (
    id          integer primary key,
    subject     varchar(255),
    content     text,
    date        timestamp,
    author_id   integer not null references users(id),
    topic_id    integer references forum_topics(id),
    edited_by   integer references users(id),
    edit_date   timestamp
);

create table forum_post_attachments (
    forum_post_id   integer not null references forum_posts(id),
    file_id         integer not null unique references files(id),
  primary key (forum_post_id, file_id)
);

alter table forums add constraint fk_forum_last_post
    foreign key (last_post_id) references forum_posts(id);

alter table forum_topics add constraint fk_forum_topic_first_post
    foreign key (first_post_id) references forum_posts(id);

alter table forum_topics add constraint fk_forum_topic_last_post 
    foreign key (last_post_id) references forum_posts(id);

alter table forum_posts add column tsv tsvector;

create function forum_posts_ts_trigger_function() returns trigger as $$
declare
    author users%rowtype;
begin
    select * into author from users where id = new.author_id;
    new.tsv :=
        setweight( to_tsvector('pg_catalog.english', coalesce(author.username,'')), 'A') ||
        setweight( to_tsvector('pg_catalog.english', coalesce(new.subject,'')), 'A') ||
        setweight( to_tsvector('pg_catalog.english', coalesce(new.content,'')), 'D' );
    return new;
end
$$ language plpgsql;

create trigger forum_posts_ts_trigger
    before insert or update
    on forum_posts
    for each row
    execute procedure forum_posts_ts_trigger_function();

create index forum_posts_ts_index on forum_posts using gin(tsv);

----------
-- news --
----------

create table news (
    id          integer primary key,
    topic_id    integer not null unique references forum_topics(id),
    expire_date timestamp
);

----------
-- wiki --
----------

create table wiki_pages (
    id              integer primary key,
    path            varchar(1000) not null unique,
    owner_id        integer not null references users(id),
    password        varchar(255),
    locked          boolean not null default 'f'
);

create table wiki_revisions (
    id                  integer primary key,
    subject             varchar(1000),
    content             text,
    date                timestamp,
    author_id           integer not null references users(id),
    page_id             integer not null references wiki_pages(id),
    include_sidebar     boolean not null default 'f'
);

create table wiki_discussions (
    page_id     integer not null references wiki_pages(id),
    topic_id    integer not null unique references forum_topics(id),
  primary key (page_id, topic_id)
);

alter table wiki_pages add column tsv tsvector;
alter table wiki_pages add column ts_subject varchar(1000);
alter table wiki_pages add column ts_content text;

create function wiki_revisions_ts_trigger_function() returns trigger as $$
begin
    update wiki_pages set tsv =
        setweight( to_tsvector('pg_catalog.english', coalesce(new.subject,'')), 'A') ||
        setweight( to_tsvector('pg_catalog.english', coalesce(new.content,'')), 'D' ),
        ts_subject = new.subject,
        ts_content = new.content
        where id = new.page_id;
    return new;
end
$$ language plpgsql;

create trigger wiki_revisions_ts_trigger
    before insert
    on wiki_revisions
    for each row
    execute procedure wiki_revisions_ts_trigger_function();

create index wiki_pages_ts_index on wiki_pages using gin(tsv);

-------------
-- logging --
-------------

create table log_requests (
    id          integer primary key,
    uri         varchar(2000),
    method      varchar(255),
    protocol    varchar(255),
    username    varchar(255),
    address     varchar(255),
    browser     varchar(2000),
    session     varchar(255),
    timestamp   timestamp default current_timestamp
);

create table log_request_parameters (
    request_id  integer not null references log_requests(id),
    param_name  varchar(255) not null,
    param_value varchar(8000),
  primary key (request_id, param_name)
);

create table log_events (
    id          integer primary key,
    url         varchar(1000),
    session     varchar(255),
    event       varchar(255),
    details     varchar(9000),
    timestamp   timestamp
);

--------------------------------
-- calendar: events and tasks --
--------------------------------
     
create table events (
    id              integer primary key,
    title           varchar(255) not null,
    description     varchar(4092),
    startTime       timestamp not null,
    endTime         timestamp not null,
    open            boolean not null,
    section_id      integer references sections(id),
    creator_id      integer not null references users(id)
);

alter table events add column tsv tsvector;

create function events_ts_trigger_function() returns trigger as $$
begin
	new.tsv := 
	    setweight( to_tsvector('pg_catalog.english', coalesce(new.title,'')), 'A') ||
	    setweight( to_tsvector('pg_catalog.english', coalesce(new.description,'')), 'D');
	return new;    
end 
$$ language plpgsql;

create trigger events_ts_trigger
    before insert or update
    on events
    for each row
    execute procedure events_ts_trigger_function();
    
create index events_ts_index on events using gin(tsv);    



create table events_files (
    event_id        integer not null references events(id),
    file_id         integer not null references files(id),
    primary key (event_id, file_id)
);

create table tasks (
    id              integer primary key,
    title           varchar(255) not null,
    completed_date  timestamp,
    creator_id      integer not null references users(id)
);


