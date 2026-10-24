# src/ — Codigo fuente (produccion Semestre 2027-1)

Esta carpeta contendra el codigo fuente de ContractAI cuando el proyecto
entre en fase de construccion en el proximo semestre.

## Stack tecnologico definido

| Capa | Tecnologia | Version |
|---|---|---|
| Frontend | Next.js + React | 16.x / 19.x |
| Lenguaje | TypeScript | 5.x |
| Estilos | Tailwind CSS | 3.x |
| Backend / API | Next.js API Routes (Route Handlers) | 16.x |
| ORM / BD | Prisma + MySQL / MariaDB | 5.x |
| IA | API de Groq (Llama 3.3-70b) | — |
| Firma digital | Canvas API + hash SHA-256 (crypto) | — |
| Autenticacion | NextAuth.js | 5.x |
| Despliegue | Vercel (frontend) + Railway (BD) | — |

## Arquitectura: MVC adaptado a Next.js

```
src/
  app/                    ← Vista (pages + layouts)
    (auth)/               ← login, registro, recuperar-contrasena
    contratos/            ← CRUD contratos
    firma/                ← canvas firma digital
    admin/                ← panel administrador
    api/                  ← Controlador (Route Handlers)
      auth/
      contratos/
      firma/
      ia/
  lib/                    ← Modelo (logica de negocio + acceso a datos)
    models/               ← Clases de dominio
    services/             ← Servicios (AuthService, ContratoService, IAService)
    prisma/               ← Schema de base de datos
  components/             ← Componentes reutilizables (Vista)
```

## Equivalencia MVC del curso

| MVC (curso) | Equivalente Next.js |
|---|---|
| Controlador | `app/api/*/route.ts` |
| Modelo | `lib/models/` + `lib/services/` |
| Vista | `app/**/page.tsx` + `components/` |

## Estado actual

- [ ] Estructura de carpetas
- [ ] Configuracion de Prisma + MySQL
- [ ] Modulo de autenticacion (HU-04, HU-21, HU-22)
- [ ] CRUD de contratos — vertical slice (HU-01, HU-03)
- [ ] Integracion de IA (HU-02, HU-12)
- [ ] Firma digital (HU-05, HU-17)
- [ ] Panel de administracion (HU-19, HU-20, HU-24)
