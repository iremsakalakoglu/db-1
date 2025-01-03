create table cache
(
    `key`      varchar(255) not null
        primary key,
    value      mediumtext   not null,
    expiration int          not null
)
    collate = utf8mb4_unicode_ci;

create table cache_locks
(
    `key`      varchar(255) not null
        primary key,
    owner      varchar(255) not null,
    expiration int          not null
)
    collate = utf8mb4_unicode_ci;

create table categories
(
    id          bigint unsigned auto_increment
        primary key,
    name        varchar(255) not null,
    description text         not null
)
    collate = utf8mb4_unicode_ci;

create table companies
(
    id         bigint unsigned auto_increment
        primary key,
    name       varchar(255) not null,
    address    varchar(255) not null,
    phone      varchar(255) not null,
    created_at timestamp    null,
    updated_at timestamp    null
)
    collate = utf8mb4_unicode_ci;

create table contracts
(
    id               bigint unsigned auto_increment
        primary key,
    company_id       bigint unsigned not null,
    contract_type    varchar(255)    not null,
    contract_details text            not null,
    start_date       date            not null,
    end_date         date            not null,
    created_at       timestamp       null,
    updated_at       timestamp       null,
    constraint contracts_company_id_foreign
        foreign key (company_id) references companies (id)
)
    collate = utf8mb4_unicode_ci;

create table currencies
(
    id            bigint unsigned auto_increment
        primary key,
    currency_code char(3)      not null,
    currency_name varchar(255) not null,
    exchange_rate double       not null,
    created_at    timestamp    null,
    updated_at    timestamp    null
)
    collate = utf8mb4_unicode_ci;

create table failed_jobs
(
    id         bigint unsigned auto_increment
        primary key,
    uuid       varchar(255)                        not null,
    connection text                                not null,
    queue      text                                not null,
    payload    longtext                            not null,
    exception  longtext                            not null,
    failed_at  timestamp default CURRENT_TIMESTAMP not null,
    constraint failed_jobs_uuid_unique
        unique (uuid)
)
    collate = utf8mb4_unicode_ci;

create table job_batches
(
    id             varchar(255) not null
        primary key,
    name           varchar(255) not null,
    total_jobs     int          not null,
    pending_jobs   int          not null,
    failed_jobs    int          not null,
    failed_job_ids longtext     not null,
    options        mediumtext   null,
    cancelled_at   int          null,
    created_at     int          not null,
    finished_at    int          null
)
    collate = utf8mb4_unicode_ci;

create table jobs
(
    id           bigint unsigned auto_increment
        primary key,
    queue        varchar(255)     not null,
    payload      longtext         not null,
    attempts     tinyint unsigned not null,
    reserved_at  int unsigned     null,
    available_at int unsigned     not null,
    created_at   int unsigned     not null
)
    collate = utf8mb4_unicode_ci;

create index jobs_queue_index
    on jobs (queue);

create table migrations
(
    id        int unsigned auto_increment
        primary key,
    migration varchar(255) not null,
    batch     int          not null
)
    collate = utf8mb4_unicode_ci;

create table password_reset_tokens
(
    email      varchar(255) not null
        primary key,
    token      varchar(255) not null,
    created_at timestamp    null
)
    collate = utf8mb4_unicode_ci;

create table payments
(
    id             bigint unsigned auto_increment
        primary key,
    order_id       bigint unsigned not null,
    created_at     timestamp       null,
    updated_at     timestamp       null,
    amount         double          not null,
    payment_method varchar(255)    not null
)
    collate = utf8mb4_unicode_ci;

create table products
(
    id          bigint unsigned auto_increment
        primary key,
    name        varchar(255)    not null,
    description text            not null,
    price       double          not null,
    category_id bigint unsigned not null,
    created_at  timestamp       null,
    updated_at  timestamp       null,
    constraint products_category_id_foreign
        foreign key (category_id) references categories (id)
)
    collate = utf8mb4_unicode_ci;

create table inventories
(
    id             bigint unsigned auto_increment
        primary key,
    product_id     bigint unsigned not null,
    stock_quantity int             not null,
    created_at     timestamp       null,
    updated_at     timestamp       null,
    constraint inventories_product_id_foreign
        foreign key (product_id) references products (id)
)
    collate = utf8mb4_unicode_ci;

create table product_attributes
(
    id              bigint unsigned auto_increment
        primary key,
    product_id      bigint unsigned not null,
    attribute_name  varchar(255)    not null,
    attribute_value varchar(255)    not null,
    created_at      timestamp       null,
    updated_at      timestamp       null,
    constraint product_attributes_product_id_foreign
        foreign key (product_id) references products (id)
)
    collate = utf8mb4_unicode_ci;

create table product_images
(
    id         bigint unsigned auto_increment
        primary key,
    product_id bigint unsigned not null,
    image_url  varchar(255)    not null,
    created_at timestamp       null,
    updated_at timestamp       null,
    constraint product_images_product_id_foreign
        foreign key (product_id) references products (id)
)
    collate = utf8mb4_unicode_ci;

create table regions
(
    id          bigint unsigned auto_increment
        primary key,
    country     varchar(255) not null,
    city        varchar(255) not null,
    region_code varchar(255) not null,
    created_at  timestamp    null,
    updated_at  timestamp    null
)
    collate = utf8mb4_unicode_ci;

create table replenishment_requests
(
    id                 bigint unsigned auto_increment
        primary key,
    product_id         bigint unsigned not null,
    supplier_id        bigint unsigned not null,
    quantity_requested int             not null,
    created_at         timestamp       null,
    updated_at         timestamp       null,
    status             varchar(255)    not null,
    constraint replenishment_requests_product_id_foreign
        foreign key (product_id) references products (id)
)
    collate = utf8mb4_unicode_ci;

create table sessions
(
    id            varchar(255)    not null
        primary key,
    user_id       bigint unsigned null,
    ip_address    varchar(45)     null,
    user_agent    text            null,
    payload       longtext        not null,
    last_activity int             not null
)
    collate = utf8mb4_unicode_ci;

create index sessions_last_activity_index
    on sessions (last_activity);

create index sessions_user_id_index
    on sessions (user_id);

create table suppliers
(
    id           bigint unsigned auto_increment
        primary key,
    name         varchar(255) not null,
    contact_name varchar(255) not null,
    phone        varchar(255) not null,
    email        varchar(255) not null,
    address      varchar(255) not null
)
    collate = utf8mb4_unicode_ci;

create table users
(
    id                bigint unsigned auto_increment
        primary key,
    name              varchar(255) not null,
    email             varchar(255) not null,
    email_verified_at timestamp    null,
    password          varchar(255) not null,
    remember_token    varchar(100) null,
    created_at        timestamp    null,
    updated_at        timestamp    null,
    constraint users_email_unique
        unique (email)
)
    collate = utf8mb4_unicode_ci;

create table activity_logs
(
    id               bigint unsigned auto_increment
        primary key,
    user_id          bigint unsigned not null,
    activity_type    varchar(255)    not null,
    activity_details text            not null,
    created_at       timestamp       null,
    updated_at       timestamp       null,
    constraint activity_logs_user_id_foreign
        foreign key (user_id) references users (id)
)
    collate = utf8mb4_unicode_ci;

create table document_uploads
(
    id            bigint unsigned auto_increment
        primary key,
    user_id       bigint unsigned not null,
    document_type varchar(255)    not null,
    file_path     varchar(255)    not null,
    created_at    timestamp       null,
    updated_at    timestamp       null,
    constraint document_uploads_user_id_foreign
        foreign key (user_id) references users (id)
)
    collate = utf8mb4_unicode_ci;

create table email_notifications
(
    id            bigint unsigned auto_increment
        primary key,
    user_id       bigint unsigned not null,
    email_subject varchar(255)    not null,
    email_body    varchar(255)    not null,
    created_at    timestamp       null,
    updated_at    timestamp       null,
    status        varchar(255)    not null,
    constraint email_notifications_user_id_foreign
        foreign key (user_id) references users (id)
)
    collate = utf8mb4_unicode_ci;

create table feedback
(
    id            bigint unsigned auto_increment
        primary key,
    user_id       bigint unsigned not null,
    feedback_text text            not null,
    rating        int             not null,
    created_at    timestamp       null,
    updated_at    timestamp       null,
    constraint feedback_user_id_foreign
        foreign key (user_id) references users (id)
)
    collate = utf8mb4_unicode_ci;

create table orders
(
    id         bigint unsigned auto_increment
        primary key,
    user_id    bigint unsigned not null,
    created_at timestamp       null,
    updated_at timestamp       null,
    status     varchar(255)    not null,
    constraint orders_user_id_foreign
        foreign key (user_id) references users (id)
)
    collate = utf8mb4_unicode_ci;

create table order_details
(
    id         bigint unsigned auto_increment
        primary key,
    order_id   bigint unsigned not null,
    product_id bigint unsigned not null,
    quantity   int             not null,
    price      double          not null,
    constraint order_details_order_id_foreign
        foreign key (order_id) references orders (id),
    constraint order_details_product_id_foreign
        foreign key (product_id) references products (id)
)
    collate = utf8mb4_unicode_ci;

create table product_reviews
(
    id         bigint unsigned auto_increment
        primary key,
    product_id bigint unsigned not null,
    user_id    bigint unsigned not null,
    rating     int             not null,
    review     text            not null,
    created_at timestamp       null,
    updated_at timestamp       null,
    constraint product_reviews_product_id_foreign
        foreign key (product_id) references products (id),
    constraint product_reviews_user_id_foreign
        foreign key (user_id) references users (id)
)
    collate = utf8mb4_unicode_ci;

create table shipping_addresses
(
    id          bigint unsigned auto_increment
        primary key,
    order_id    bigint unsigned not null,
    address     varchar(255)    not null,
    city        varchar(255)    not null,
    postal_code varchar(255)    not null,
    country     varchar(255)    not null,
    constraint shipping_addresses_order_id_foreign
        foreign key (order_id) references orders (id)
)
    collate = utf8mb4_unicode_ci;

create table support_tickets
(
    id         bigint unsigned auto_increment
        primary key,
    user_id    bigint unsigned not null,
    subject    varchar(255)    not null,
    message    text            not null,
    status     varchar(255)    not null,
    created_at timestamp       null,
    updated_at timestamp       null,
    constraint support_tickets_user_id_foreign
        foreign key (user_id) references users (id)
)
    collate = utf8mb4_unicode_ci;

create table user_roles
(
    id      bigint unsigned auto_increment
        primary key,
    user_id bigint unsigned not null,
    role    varchar(255)    not null,
    constraint user_roles_user_id_foreign
        foreign key (user_id) references users (id)
)
    collate = utf8mb4_unicode_ci;


