import express, { Application } from "express";

export const router = (app: Application) => {
  app.route("/").get((req, res) => res.status(200).json({ message: "Hello Condominial!" }));
  app.use(express.json());
};
