// --- CONFIGURATION ---
const BREVO_API_KEY = "PASTE_YOUR_BREVO_API_KEY_HERE"; 
const SENDER_EMAIL = "aran.locker@gmail.com"; 
const GOOGLE_BACKEND_URL = "https://script.google.com/macros/s/AKfycbxXAjezktvwwvYKGbt94RaoCDAY-0FMQqvr7O7nPc6ehdZ8bywm0GovHHBphDCXyF4P/exec"; 
const VAULT_MASTER_KEY = "VaultX-Super-Secret-Key-2026"; 

// --- STATE MANAGEMENT ---
let generatedOTP = null;
let userEmail = "";
let userName = "";

function showScreen(screenId) {
    console.log("Switching to screen:", screenId);
    const screens = document.querySelectorAll('.screen');
    screens.forEach(s => s.classList.add('hidden'));
    
    const activeScreen = document.getElementById(screenId);
    if (activeScreen) {
        activeScreen.classList.remove('hidden');
        if (screenId === 'dashboard') loadDocuments();
    }
}

window.addEventListener('load', () => {
    const status = document.getElementById('boot-status');
    setTimeout(() => { if(status) status.innerHTML = '<i class="fas fa-shield-check"></i> Firewall Active...'; }, 1000);
    setTimeout(() => { if(status) status.innerHTML = '<i class="fas fa-key"></i> E2E Encryption Ready...'; }, 2000);
    setTimeout(() => { showScreen('login'); }, 3500);
});

// --- AUTH LOGIC (BREVO) ---
async function handleEmailLogin() {
    const emailInput = document.getElementById('email-input');
    const email = emailInput ? emailInput.value : "";
    
    if (!email.includes('@') || email.length < 5) {
        alert("Please enter a valid email address!");
        return;
    }
    
    userEmail = email;
    const displayEmail = document.getElementById('display-email');
    if (displayEmail) displayEmail.innerText = email;
    
    generatedOTP = Math.floor(100000 + Math.random() * 900000).toString();
    showScreen('otp');

    console.log("Attempting to send OTP to:", userEmail);

    try {
        const response = await fetch('https://api.brevo.com/v3/smtp/email', {
            method: 'POST',
            headers: { 
                'accept': 'application/json',
                'api-key': BREVO_API_KEY, 
                'content-type': 'application/json' 
            },
            body: JSON.stringify({
                sender: { name: "Aran Locker Security", email: SENDER_EMAIL },
                to: [{ email: userEmail }],
                subject: "Aran-Locker Verification: " + generatedOTP,
                htmlContent: `
                    <div style="font-family: sans-serif; padding: 20px; background: #050505; color: white; border-radius: 15px;">
                        <h2 style="color: #FFD700;">அரண்-Locker</h2>
                        <p>Your verification code is:</p>
                        <h1 style="letter-spacing: 10px; color: #7000FF;">${generatedOTP}</h1>
                        <p style="font-size: 12px; color: #666;">Security Protocol: AES-256 Enabled</p>
                    </div>
                `
            })
        });

        const result = await response.json();
        if (response.ok) {
            console.log("OTP Sent Successfully!");
        } else {
            console.error("Brevo Error:", result);
            alert("Brevo Error: " + JSON.stringify(result));
        }
    } catch (e) { 
        console.error("Network Error:", e);
        alert("Network Error: " + e.message); 
    }
}

function moveFocus(current, nextIndex) {
    if (current.value.length === 1) {
        const inputs = document.querySelectorAll('.otp-input');
        if (inputs[nextIndex]) inputs[nextIndex].focus();
    }
}

function verifyEmailOTP() {
    const inputs = document.querySelectorAll('.otp-input');
    let enteredOTP = "";
    inputs.forEach(input => enteredOTP += input.value);
    
    if (enteredOTP === generatedOTP) {
        showScreen('profile-setup');
    } else {
        alert("Invalid Security Code!");
    }
}

// --- ONBOARDING LOGIC ---
let selectedGender = "male";

function selectGender(gender, element) {
    selectedGender = gender;
    document.querySelectorAll('.gender-pill').forEach(p => p.classList.remove('active'));
    element.classList.add('active');
}

function skipProfile() {
    userName = "Aran User";
    showScreen('security-setup');
}

function saveProfile() {
    const nameInput = document.getElementById('name-input');
    const name = nameInput ? nameInput.value : "";
    if (name.length < 2) return alert("Please enter your name");
    userName = name;
    document.getElementById('display-name').innerText = userName;
    showScreen('security-setup');
}

function checkPinInput(input) {
    const card = document.getElementById('biometric-card');
    if (input.value.length === 4) {
        card.style.opacity = "1";
        card.style.pointerEvents = "all";
    } else {
        card.style.opacity = "0.5";
        card.style.pointerEvents = "none";
    }
}

function skipSecurity() {
    showScreen('dashboard');
}

function saveSecurity() {
    const pin = document.getElementById('setup-pin').value;
    const bioEnabled = document.getElementById('biometric-toggle').checked;
    
    if (pin.length > 0 && pin.length < 4) return alert("PIN must be 4 digits");
    
    if (pin) localStorage.setItem('vault_pin', pin);
    localStorage.setItem('biometric_enabled', bioEnabled);
    
    showScreen('dashboard');
}

async function uploadToBackend(file) {
    if (!GOOGLE_BACKEND_URL || GOOGLE_BACKEND_URL.includes("YOUR_GOOGLE")) return alert("Backend URL Missing!");

    const reader = new FileReader();
    reader.onload = async function() {
        const rawData = reader.result;
        const status = document.getElementById('upload-status');
        status.innerText = "🔒 Encrypting with AES-256...";
        
        try {
            const encrypted = CryptoJS.AES.encrypt(rawData, VAULT_MASTER_KEY).toString();
            status.innerText = "☁️ Uploading to Secure Vault...";
            
            const response = await fetch(GOOGLE_BACKEND_URL, {
                method: 'POST',
                body: JSON.stringify({
                    action: "upload",
                    email: userEmail,
                    fileName: file.name + ".vault",
                    fileData: encrypted,
                    mimeType: "application/octet-stream",
                    category: "Secure"
                })
            });
            const result = await response.json();
            if (result.status === "success") {
                alert("SUCCESS! File Encrypted & Saved Securely.");
                showScreen('dashboard');
            }
        } catch (e) { 
            console.error(e);
            alert("Upload failed: " + e.message); 
        }
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
        if (status) status.innerText = "AI Scanning...";
        if (scanLine) scanLine.classList.remove('hidden');
        setTimeout(() => {
            if (scanLine) scanLine.classList.add('hidden');
            uploadToBackend(file);
        }, 2000);
    };
    input.click();
}

function unlockVault() {
    const pin = document.getElementById('vault-pin').value;
    if (pin === '1234') {
        document.getElementById('vault-lock').style.display = 'none';
        document.getElementById('vault-content').classList.remove('hidden');
    } else alert("Invalid PIN!");
}
