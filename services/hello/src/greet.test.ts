import { expect, it } from "vitest";
import { greet } from "./greet.js";

it("greets", () => expect(greet("x")).toBe("hello x"));
