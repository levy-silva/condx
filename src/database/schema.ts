import { pgTable, char, integer, varchar, timestamp } from "drizzle-orm/pg-core";

const id = { id: integer("id").primaryKey().generatedAlwaysAsIdentity() };

const timestamps = {
  createdAt: timestamp("created_at", {
    withTimezone: true,
  })
    .defaultNow()
    .notNull(),

  updatedAt: timestamp("updated_at", {
    withTimezone: true,
  })
    .defaultNow()
    .notNull(),
};

export const departments = pgTable("departments", {
  ...id,
  nome: varchar("nome").notNull().unique(),
  ...timestamps,
});

export const employees = pgTable("employees", {
  ...id,
  nome: varchar("nome", { length: 255 }).notNull(),
  email: varchar("email", { length: 255 }).notNull().unique(),
  departamento_id: integer("departamento_id")
    .notNull()
    .references(() => departments.id, {
      onDelete: "cascade",
      onUpdate: "cascade",
    }),
  ...timestamps,
});

export const portfolios = pgTable("portfolios", {
  ...id,
  apelido: varchar("apelido", { length: 50 }).notNull().unique(),

  employeeId: integer("employee_id")
    .notNull()
    .references(() => employees.id, {
      onDelete: "cascade",
      onUpdate: "cascade",
    }),
  ...timestamps,
});

export const condominiums = pgTable("condominiums", {
  ...id,
  razaoSocial: varchar("razao_social", { length: 255 }).notNull(),
  nomeFantasia: varchar("nome_fantasia", { length: 100 }).notNull(),
  cnpj: varchar("cnpj", { length: 14 }).notNull().unique(),
  endereco: varchar("endereco").notNull(),
  numero: varchar("numero", { length: 11 }),
  bairro: varchar("bairro", { length: 100 }).notNull(),
  complemento: varchar("complemento", { length: 100 }),
  cidade: varchar("cidade", { length: 100 }).notNull(),
  uf: char("uf", { length: 2 }).notNull(),
  cep: char("cep", { length: 8 }).notNull(),

  portfolioId: integer("portfolio_id").references(() => departments.id, {
    onDelete: "cascade",
    onUpdate: "cascade",
  }),
  ...timestamps,
});
