<%-- 
    Document   : adminPanel
    Created on : 4 Jun, 2026, 12:04:32 AM
    Author     : Anunay 
--%>
<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Profile – E-lib Store</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css" />
        <style>
            * { box-sizing: border-box; margin: 0; padding: 0; }

            body {
                font-family: Arial, sans-serif;
                background: #e8e6f0;
                min-height: 100vh;
                color: #2e2b4a;
            }

            /* ── Navbar ── */
            .navbar {
                background: #2e2b4a;
                padding: 0 32px;
                height: 56px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .navbar-brand {
                display: flex;
                align-items: center;
                gap: 10px;
                text-decoration: none;
            }

            .navbar-brand .nav-icon {
                width: 32px; height: 32px;
                background: rgba(174,169,236,0.18);
                border-radius: 8px;
                display: flex; align-items: center; justify-content: center;
            }

            .navbar-brand .nav-icon i { font-size: 18px; color: #c8c4f0; }
            .navbar-brand span { font-size: 16px; font-weight: 600; color: #eeedf8; }

            .navbar-back {
                display: flex;
                align-items: center;
                gap: 6px;
                font-size: 13px;
                color: #a8a4cc;
                text-decoration: none;
                transition: color 0.15s;
            }

            .navbar-back:hover { color: #eeedf8; }
            .navbar-back i { font-size: 16px; }

            /* ── Page wrapper ── */
            .page-wrapper {
                max-width: 620px;
                margin: 0 auto;
                padding: 36px 24px 56px;
            }

            /* ── Avatar header ── */
            .profile-header {
                display: flex;
                align-items: center;
                gap: 18px;
                margin-bottom: 28px;
            }

            .avatar {
                width: 56px; height: 56px;
                border-radius: 50%;
                background: #4e4798;
                display: flex; align-items: center; justify-content: center;
                flex-shrink: 0;
            }

            .avatar i { font-size: 28px; color: #c8c4f0; }

            .profile-header-text h2 {
                font-size: 18px;
                font-weight: 600;
                color: #2e2b4a;
                margin-bottom: 2px;
            }

            .profile-header-text p {
                font-size: 13px;
                color: #7a7896;
            }

            /* ── Cards ── */
            .card {
                background: #f2f0f7;
                border-radius: 14px;
                border: 1px solid #d4d2e3;
                overflow: hidden;
                margin-bottom: 20px;
            }

            .card-header {
                padding: 16px 24px;
                border-bottom: 1px solid #d4d2e3;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .card-header i { font-size: 18px; color: #6c63b8; }

            .card-header h3 {
                font-size: 15px;
                font-weight: 600;
                color: #2e2b4a;
            }

            .card-body { padding: 24px; }

            /* ── Form fields ── */
            .form-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 16px;
            }

            .field { display: flex; flex-direction: column; gap: 6px; }
            .field.full-width { grid-column: 1 / -1; }

            .field label {
                font-size: 13px;
                font-weight: 600;
                color: #4a4868;
            }

            .input-wrap { position: relative; }

            .input-wrap .icon-left {
                position: absolute;
                left: 11px; top: 50%;
                transform: translateY(-50%);
                font-size: 16px;
                color: #9b99b8;
                pointer-events: none;
            }

            .input-wrap input {
                width: 100%;
                height: 42px;
                padding: 0 12px 0 36px;
                border: 1px solid #d4d2e3;
                border-radius: 8px;
                background: #eceaf4;
                color: #2e2b4a;
                font-size: 14px;
                font-family: Arial, sans-serif;
                outline: none;
                transition: border-color 0.15s, box-shadow 0.15s;
            }

            .input-wrap input:focus {
                border-color: #6c63b8;
                box-shadow: 0 0 0 3px rgba(108,99,184,0.12);
                background: #ebe9f5;
            }

            .toggle-pw {
                position: absolute;
                right: 11px; top: 50%;
                transform: translateY(-50%);
                background: none;
                border: none;
                cursor: pointer;
                color: #9b99b8;
                padding: 0;
                font-size: 17px;
                line-height: 1;
            }

            .toggle-pw:hover { color: #6c63b8; }

            /* ── Confirm password box ── */
            .confirm-box {
                margin-top: 20px;
                padding: 16px;
                background: #eceaf4;
                border-radius: 10px;
                border: 1px solid #c8c4e8;
            }

            .confirm-box .confirm-label {
                font-size: 12px;
                font-weight: 600;
                color: #6c63b8;
                margin-bottom: 10px;
                display: flex;
                align-items: center;
                gap: 6px;
            }

            .confirm-box .confirm-label i { font-size: 14px; }

            /* ── Form divider ── */
            .form-divider {
                height: 1px;
                background: #d4d2e3;
                margin: 20px 0;
            }

            /* ── Actions ── */
            .form-actions {
                display: flex;
                justify-content: flex-end;
            }

            .btn-primary {
                height: 40px;
                padding: 0 24px;
                background: #4e4798;
                color: #eeedf8;
                border: none;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                font-family: Arial, sans-serif;
                display: flex;
                align-items: center;
                gap: 7px;
                transition: background 0.15s, transform 0.1s;
            }

            .btn-primary:hover { background: #3b3478; }
            .btn-primary:active { transform: scale(0.98); }
            .btn-primary i { font-size: 16px; }

            /* ── Danger zone ── */
            .danger-card {
                background: #fdf5f5;
                border-radius: 14px;
                border: 1px solid #e8c8c8;
                overflow: hidden;
            }

            .danger-card .card-header {
                border-bottom: 1px solid #e8c8c8;
            }

            .danger-card .card-header i { color: #c0504a; }
            .danger-card .card-header h3 { color: #2e2b4a; }

            .danger-card .card-body { padding: 24px; }

            .danger-warning {
                font-size: 13px;
                color: #7a7896;
                margin-bottom: 16px;
                line-height: 1.6;
            }

            .danger-warning strong { color: #c0504a; }

            .danger-row {
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .danger-row .input-wrap { flex: 1; }

            .btn-danger {
                height: 42px;
                padding: 0 20px;
                background: #c0504a;
                color: #fff;
                border: none;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                font-family: Arial, sans-serif;
                display: flex;
                align-items: center;
                gap: 7px;
                white-space: nowrap;
                flex-shrink: 0;
                transition: background 0.15s, transform 0.1s;
            }

            .btn-danger:hover { background: #a03f3a; }
            .btn-danger:active { transform: scale(0.98); }
            .btn-danger i { font-size: 16px; }

            @media (max-width: 560px) {
                .form-grid { grid-template-columns: 1fr; }
                .field.full-width { grid-column: 1; }
                .danger-row { flex-direction: column; align-items: stretch; }
                .page-wrapper { padding: 20px 16px 40px; }
            }
        </style>
    </head>
    <body>

        <%
            UserDTO user = (UserDTO)session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>

        <!-- Navbar -->
        <nav class="navbar">
            <a href="#" class="navbar-brand">
                <div class="nav-icon"><i class="ti ti-book-2"></i></div>
                <span>E-lib Store</span>
            </a>
            <a href="javascript:history.back()" class="navbar-back">
                <i class="ti ti-arrow-left"></i>
                Back
            </a>
        </nav>

        <div class="page-wrapper">

            <!-- Profile header -->
            <div class="profile-header">
                <div class="avatar"><i class="ti ti-user"></i></div>
                <div class="profile-header-text">
                    <h2><%=user.getUsername()%></h2>
                    <p>Manage your account details below.</p>
                </div>
            </div>

            <!-- Update profile card -->
            <div class="card">
                <div class="card-header">
                    <i class="ti ti-user-edit"></i>
                    <h3>Update profile</h3>
                </div>
                <div class="card-body">
                    <form name="myForm" action="UpdateProfile" method="post">

                        <div class="form-grid">

                            <div class="field">
                                <label for="username">Username</label>
                                <div class="input-wrap">
                                    <i class="ti ti-user icon-left"></i>
                                    <input type="text" id="username" name="username"
                                           value="<%=user.getUsername()%>" />
                                </div>
                            </div>

                            <div class="field">
                                <label for="usermail">Email address</label>
                                <div class="input-wrap">
                                    <i class="ti ti-mail icon-left"></i>
                                    <input type="text" id="usermail" name="usermail"
                                           value="<%=user.getUsermail()%>" />
                                </div>
                            </div>

                            <div class="field">
                                <label for="usercontact">Contact number</label>
                                <div class="input-wrap">
                                    <i class="ti ti-phone icon-left"></i>
                                    <input type="text" id="usercontact" name="usercontact"
                                           value="<%=user.getUsercontact()%>" />
                                </div>
                            </div>

                            <div class="field">
                                <label for="userpassword">New password</label>
                                <div class="input-wrap">
                                    <i class="ti ti-lock icon-left"></i>
                                    <input type="password" id="userpassword" name="userpassword"
                                           placeholder="Leave blank to keep current" autocomplete="off" />
                                    <button type="button" class="toggle-pw" aria-label="Show password" onclick="togglePw(this)">
                                        <i class="ti ti-eye"></i>
                                    </button>
                                </div>
                            </div>

                        </div>

                        <div class="confirm-box">
                            <div class="confirm-label">
                                <i class="ti ti-shield-lock"></i>
                                Enter your current password to confirm changes
                            </div>
                            <div class="input-wrap">
                                <i class="ti ti-lock icon-left"></i>
                                <input type="password" name="current_password"
                                       placeholder="Current password" autocomplete="off" />
                                <button type="button" class="toggle-pw" aria-label="Show password" onclick="togglePw(this)">
                                    <i class="ti ti-eye"></i>
                                </button>
                            </div>
                        </div>

                        <div class="form-divider"></div>

                        <div class="form-actions">
                            <button type="submit" class="btn-primary">
                                <i class="ti ti-device-floppy"></i>
                                Save changes
                            </button>
                        </div>

                    </form>
                </div>
            </div>

            <!-- Danger zone -->
            <div class="danger-card">
                <div class="card-header">
                    <i class="ti ti-alert-triangle"></i>
                    <h3>Delete account</h3>
                </div>
                <div class="card-body">
                    <p class="danger-warning">
                        This action is <strong>permanent and cannot be undone.</strong>
                        All your data will be removed. Enter your current password to confirm.
                    </p>
                    <form action="DeleteProfile" method="post">
                        <div class="danger-row">
                            <div class="input-wrap">
                                <i class="ti ti-lock icon-left"></i>
                                <input type="password" name="current_password"
                                       placeholder="Enter current password" autocomplete="off" />
                            </div>
                            <button type="submit" class="btn-danger">
                                <i class="ti ti-trash"></i>
                                Delete account
                            </button>
                        </div>
                    </form>
                </div>
            </div>

        </div>

        <script>
            function togglePw(btn) {
                var input = btn.closest('.input-wrap').querySelector('input');
                var icon  = btn.querySelector('i');
                if (input.type === 'password') {
                    input.type = 'text';
                    icon.className = 'ti ti-eye-off';
                    btn.setAttribute('aria-label', 'Hide password');
                } else {
                    input.type = 'password';
                    icon.className = 'ti ti-eye';
                    btn.setAttribute('aria-label', 'Show password');
                }
            }
        </script>

    </body>
</html>