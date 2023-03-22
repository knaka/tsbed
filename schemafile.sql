CREATE TABLE authors(
  id SERIAL PRIMARY KEY,
  name text NOT NULL,
  email text NOT NULL,
  created_at timestamp with time zone NOT NULL,
  updated_at timestamp with time zone NOT NULL
);

CREATE TABLE books(
  id SERIAL PRIMARY KEY,
  author_id int NOT NULL REFERENCES authors(id),
  name text NOT NULL
);
