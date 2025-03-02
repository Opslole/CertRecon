# CertRecon
Subdomain enumeration using SSL certificates from crt.sh

# 🔎 **CertRecon** 
is a powerful **Bash-based reconnaissance tool** designed for **web bug bounty hunters**.  
It helps in **subdomain enumeration** using **SSL certificates from crt.sh** and performs **HTTP status checks** on the discovered subdomains. 🚀  

## ✨ Features  
✅ **SSL Certificate Subdomain Enumeration** - Extract subdomains from `crt.sh` 📜  
✅ **Automatic HTTP Status Checking** - Check if subdomains are live 🌐  
✅ **Fast & Parallel Processing** - Scans multiple subdomains simultaneously ⚡  
✅ **Error Handling** - Detects invalid responses & prevents failures ❌  
✅ **Simple & Lightweight** - Pure Bash, no heavy dependencies 🏗️  

## 📜 Requirements

✅curl ;✅jq 

## 🛠️ Installation  

```
Clone the repository:

git clone https://github.com/Opslole/CertRecon.git
cd CertRecon
chmod +x CertRecon.sh
```

## 🚀 Usage
Run the script with a target domain:
```
./CertRecon.sh example.com
```

Example output:

```
[+] Fetching subdomains from crt.sh for example.com...
[*] Checking HTTP status for found subdomains...
[+] sub.example.com - Status: 200 (OK)
[!] redirect.example.com - Status: 301 (Redirect)
[-] offline.example.com - No response / Unreachable
```

## 📜 License
This project is licensed under the MIT License. Feel free to use, modify, and share.

## 🤝 Contributing
Contributions are welcome! 🎉 Feel free to submit pull requests or report issues.
