# parallele-verteilte-systeme-cert-example
Demonstration der Erstellung, Verwaltung und Nutzung von Zertifikaten (Public/Private Keys, Self-signed, Let’s Encrypt) mit Docker und Certbot. Beinhaltet praktische Beispiele für sichere Kommunikation in verteilten Systemen mit Nginx als Reverse Proxy.


## Tools und Technologie 
* Docker und Docker Compose (Containerisierung, Infrastruktur)
* Shell/Bash (Automatisierung der Zertifikatsgenerierung und -verwaltung)
* OpenSSL (Generierung und Verwaltung kryptografischer Schlüssel/Zertifikate)
* Certbot (Automatisierte Zertifikatsbeschaffung via Let’s Encrypt)
* Nginx (Reverse Proxy für HTTPS-Konfiguration und Demonstration)


Es ist somit ein technisches Praxisprojekt mit Fokus auf Infrastruktur und Sicherheit, weniger auf klassischer Anwendungsentwicklung.

## Ordnerstruktur
```
│
├── certs/                      # Ablage generierter Zertifikate und Schlüssel
│   ├── .gitignore              # Damit echte Zertifikate nicht im Repo landen
│
├── scripts/                    # Skripte für Zertifikatserstellung und Verwaltung
│   ├── generate-selfsigned.sh  # Shell-Skript für self-signed Zertifikate
│   ├── generate-keys.sh        # Skript für Public/Private-Key-Erzeugung
│   └── get-letsencrypt.sh      # Skript zur automatischen Let’s Encrypt Zertifikatserstellung
│
├── nginx/                      # Konfiguration des Reverse Proxys
│   └── nginx.conf
│
├── docker-compose.yml          # Docker Compose Setup
├── README.md                   # Projektbeschreibung und Anleitung
└── .gitignore                  # Allgemeine Git-Ausschlüsse (z.B. Docker-Volumen)
```


## Startup
Mach alle Skripte ausführbar:
```bash
  chmod +x scripts/*.sh
```

Scripte einzeln aufrufen: 
```bash
  ./scripts/generate-keys.sh
```

```bash
  ./scripts/generate-selfsigned.sh
```

```bash
  ./scripts/get-letsencrypt.sh
```
## Deployment
Voraussetzungen:
- Docker und Docker Compose muessen sowohl lokal als auch auf den Zielrechnern installiert sein.
- SSH-Zugriff auf die Zielrechner.

Das Skript `scripts/deploy.sh` uebertraegt ein selbstsigniertes Zertifikat und startet einen Nginx-Container per Docker Compose. Hosts werden als Argumente uebergeben:

```bash
./scripts/deploy.sh user@host1 user@host2
```

