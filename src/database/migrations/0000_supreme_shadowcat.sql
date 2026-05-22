CREATE TABLE "condominiums" (
	"id" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "condominiums_id_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"razao_social" varchar(255) NOT NULL,
	"nome_fantasia" varchar(100) NOT NULL,
	"cnpj" varchar(14) NOT NULL,
	"endereco" varchar NOT NULL,
	"numero" varchar(11),
	"bairro" varchar(100) NOT NULL,
	"complemento" varchar(100),
	"cidade" varchar(100) NOT NULL,
	"uf" char(2) NOT NULL,
	"cep" char(8) NOT NULL,
	"portfolio_id" integer,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "condominiums_cnpj_unique" UNIQUE("cnpj")
);
--> statement-breakpoint
CREATE TABLE "departments" (
	"id" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "departments_id_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"nome" varchar NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "departments_nome_unique" UNIQUE("nome")
);
--> statement-breakpoint
CREATE TABLE "employees" (
	"id" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "employees_id_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"nome" varchar(255) NOT NULL,
	"email" varchar(255) NOT NULL,
	"departamento_id" integer NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "employees_email_unique" UNIQUE("email")
);
--> statement-breakpoint
CREATE TABLE "portfolios" (
	"id" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "portfolios_id_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"apelido" varchar(50) NOT NULL,
	"employee_id" integer NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "portfolios_apelido_unique" UNIQUE("apelido")
);
--> statement-breakpoint
ALTER TABLE "condominiums" ADD CONSTRAINT "condominiums_portfolio_id_departments_id_fk" FOREIGN KEY ("portfolio_id") REFERENCES "public"."departments"("id") ON DELETE cascade ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE "employees" ADD CONSTRAINT "employees_departamento_id_departments_id_fk" FOREIGN KEY ("departamento_id") REFERENCES "public"."departments"("id") ON DELETE cascade ON UPDATE cascade;--> statement-breakpoint
ALTER TABLE "portfolios" ADD CONSTRAINT "portfolios_employee_id_employees_id_fk" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("id") ON DELETE cascade ON UPDATE cascade;