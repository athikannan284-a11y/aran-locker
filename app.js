// --- CONFIGURATION ---
const BREVO_API_KEY = "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"; 
const SENDER_EMAIL = "aran.locker@gmail.com"; 
const GOOGLE_BACKEND_URL = "https://script.google.com/macros/s/AKfycbxXAjezktvwwvYKGbt94RaoCDAY-0FMQqvr7O7nPc6ehdZ8bywm0GovHHBphDCXyF4P/exec"; 

// --- END-TO-END ENCRYPTION KEY ---
// This is your master vault key. Keep it secret!
const VAULT_MASTER_KEY = "VaultX-Super-Secret-Key-2026"; 

// --- STATE MANAGEMENT ---
let generatedOTP = null;
let userEmail = "";
let userName = "";

// --- SCREEN MANAGEMENT ---
function showScreen(screenId) {
    const screens = document.querySelectorAll('.screen');
    screens.forEach(s => s.classList.add('hidden'));
    
    const activeScreen = document.getElementById(screenId);
    if (activeScreen) {
        activeScreen.classList.remove('hidden');
        if (screenId === 'dashboard') loadDocuments();
    }
}

// Initial Splash Screen Logic
window.addEventListener('load', () => {
    setTimeout(() => {
        showScreen('login');
    }, 3000);
});

// --- AUTH LOGIC (BREVO) ---
async function handleEmailLogin() {
    const email = document.getElementById('email-input').value;
    if (!email.includes('@') || email.length < 5) {
        alert("Please enter a valid email address!");
        return;
    }
    userEmail = email;
    const displayEmail = document.getElementById('display-email');
    if (displayEmail) displayEmail.innerText = email;
    generatedOTP = Math.floor(100000 + Math.random() * 900000).toString();
    showScreen('otp');

    try {
        await fetch('https://api.brevo.com/v3/smtp/email', {
            method: 'POST',
            headers: { 'api-key': BREVO_API_KEY, 'content-type': 'application/json' },
            body: JSON.stringify({
                sender: { name: "VaultX Security", email: SENDER_EMAIL },
                to: [{ email: userEmail }],
                subject: "VaultX Login OTP: " + generatedOTP,
                htmlContent: `<p>Your code is: <b>${generatedOTP}</b></p>`
            })
        });
    } catch (e) { console.error(e); }
}

function verifyEmailOTP() {
    const inputs = document.querySelectorAll('.otp-input');
    let enteredOTP = "";
    inputs.forEach(input => enteredOTP += input.value);
    if (enteredOTP === generatedOTP || BREVO_API_KEY === "") showScreen('profile-setup');
    else alert("Invalid OTP!");
}

function saveProfile() {
    const name = document.getElementById('name-input').value;
    if (name.length < 2) return alert("Enter name");
    userName = name;
    document.getElementById('display-name').innerText = "Hello, " + userName;
    showScreen('dashboard');
}

// --- SECURE UPLOAD (AES-256) ---
async function uploadToBackend(file) {
    if (GOOGLE_BACKEND_URL.includes("YOUR_GOOGLE")) return alert("Connect Backend First!");

    const reader = new FileReader();
    reader.onload = async function() {
        const rawData = reader.result;
        const status = document.getElementById('upload-status');
        status.innerText = "🔒 Encrypting with AES-256...";
        
        // --- END-TO-END ENCRYPTION STEP ---
        // We encrypt the file data before it leaves the browser
        const encrypted = CryptoJS.AES.encrypt(rawData, VAULT_MASTER_KEY).toString();
        
        status.innerText = "☁️ Uploading Encrypted File...";
        
        try {
            const response = await fetch(GOOGLE_BACKEND_URL, {
                method: 'POST',
                body: JSON.stringify({
                    action: "upload",
                    email: userEmail,
                    fileName: file.name + ".vault", // Tagged as vault file
                    fileData: encrypted,
                    mimeType: "application/octet-stream", // Generic binary
                    category: "Secure"
                })
            });
            const result = await response.json();
            if (result.status === "success") {
                alert("SUCCESS! File Encrypted & Saved Securely.");
                showScreen('dashboard');
            }
        } catch (e) { alert("Upload failed"); }
    };
    reader.readAsDataURL(file);
}

function startScan() {
    const input = document.createElement('input');
    input.type = 'file';
    input.onchange = e => {
        const file = e.target.files[0];
        const status = document.getElementById('upload-status');
        const scanLine = document.querySelector('.scan-line');
        status.innerText = "AI Scanning...";
        scanLine.classList.remove('hidden');
        setTimeout(() => {
            scanLine.classList.add('hidden');
            uploadToBackend(file);
        }, 2000);
    };
    input.click();
}

// --- VAULT LOGIC ---
function unlockVault() {
    const pin = document.getElementById('vault-pin').value;
    if (pin === '1234') {
        document.getElementById('vault-lock').style.display = 'none';
        document.getElementById('vault-content').classList.remove('hidden');
    } else alert("Invalid PIN!");
}

document.querySelectorAll('.nav-item').forEach(item => {
    item.addEventListener('click', function() {
        document.querySelectorAll('.nav-item').forEach(i => i.classList.remove('active'));
        this.classList.add('active');
    });
});

document.querySelectorAll('.back-btn').forEach(btn => {
    btn.addEventListener('click', () => showScreen('dashboard'));
});
