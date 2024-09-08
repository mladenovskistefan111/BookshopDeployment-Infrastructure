--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: postgres
--

CREATE TABLE public.country (
  id SERIAL PRIMARY KEY,
  continent VARCHAR(255),
  name VARCHAR(255)
);

CREATE TABLE public.author (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  surname VARCHAR(255),
  country_id INTEGER REFERENCES public.country (id)
);

CREATE TABLE public.book (
  id SERIAL PRIMARY KEY,
  available_copies INTEGER,
  category VARCHAR(255),
  name VARCHAR(255),
  author_id INTEGER REFERENCES public.author (id)
);

INSERT INTO public.country (id, continent, name) VALUES (1, 'North America', 'USA');
INSERT INTO public.country (id, continent, name) VALUES (2, 'Europe', 'England');
INSERT INTO public.country (id, continent, name) VALUES (3, 'Europe', 'Poland');
INSERT INTO public.country (id, continent, name) VALUES (4, 'Europe', 'France');
INSERT INTO public.country (id, continent, name) VALUES (5, 'Asia', 'Russia');
INSERT INTO public.country (id, continent, name) VALUES (6, 'Asia', 'Japan');


--
-- Data for Name: author; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.author (id, name, surname, country_id) VALUES (1, 'Mark', 'Twain', 1);
INSERT INTO public.author (id, name, surname, country_id) VALUES (2, 'Leo', 'Tolstoy', 5);
INSERT INTO public.author (id, name, surname, country_id) VALUES (3, 'J.R.R', 'Tolkien', 2);
INSERT INTO public.author (id, name, surname, country_id) VALUES (4, 'Andrzej', 'Sapkowski', 3);
INSERT INTO public.author (id, name, surname, country_id) VALUES (5, 'Victor', 'Hugo', 4);
INSERT INTO public.author (id, name, surname, country_id) VALUES (6, 'Charles', 'Dickens', 2);
INSERT INTO public.author (id, name, surname, country_id) VALUES (7, 'Akira', 'Toriyama', 6);


--
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.book (id, available_copies, category, name, author_id) VALUES (12, 99, 'NOVEL', 'Adventures of Huckleberry Finn', 1);
INSERT INTO public.book (id, available_copies, category, name, author_id) VALUES (13, 145, 'HISTORY', 'War and Peace', 2);
INSERT INTO public.book (id, available_copies, category, name, author_id) VALUES (14, 49, 'NOVEL', 'Anna Karenina', 2);
INSERT INTO public.book (id, available_copies, category, name, author_id) VALUES (15, 9, 'FANTASY', 'The Witcher', 4);
INSERT INTO public.book (id, available_copies, category, name, author_id) VALUES (16, 121, 'NOVEL', 'Oliver Twist', 6);
INSERT INTO public.book (id, available_copies, category, name, author_id) VALUES (17, 67, 'DRAMA', 'A Christmas Carol', 6);
INSERT INTO public.book (id, available_copies, category, name, author_id) VALUES (18, 7, 'FANTASY', 'Dragon Ball', 7);
INSERT INTO public.book (id, available_copies, category, name, author_id) VALUES (19, 55, 'DRAMA', 'The Hunchback of Notre-Dame', 5);
INSERT INTO public.book (id, available_copies, category, name, author_id) VALUES (20, 300, 'FANTASY', 'The Lord of the Rings', 3);
INSERT INTO public.book (id, available_copies, category, name, author_id) VALUES (21, 260, 'NOVEL', 'Les Misérables', 5);


--
-- Name: author_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.author_id_seq', 7, true);


--
-- Name: book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.book_id_seq', 21, true);


--
-- Name: country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.country_id_seq', 6, true);


--
-- PostgreSQL database dump complete
--

