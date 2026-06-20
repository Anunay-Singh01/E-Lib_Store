<%-- 
    Document   : updateBook
    Created on : 13 Jun, 2026, 7:21:06 PM
    Author     : Anunay 
--%>
<%@page import="dto.BookDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Book – E-lib Store</title>
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
                max-width: 720px;
                margin: 0 auto;
                padding: 36px 24px 56px;
            }

            /* ── Section heading ── */
            .section-heading {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 24px;
            }

            .section-heading i { font-size: 20px; color: #6c63b8; }

            .section-heading h2 {
                font-size: 18px;
                font-weight: 600;
                color: #2e2b4a;
            }

            /* ── Main card ── */
            .edit-card {
                background: #f2f0f7;
                border-radius: 14px;
                border: 1px solid #d4d2e3;
                overflow: hidden;
            }

            /* ── Cover preview strip ── */
            .cover-strip {
                background: #2e2b4a;
                padding: 28px 32px;
                display: flex;
                align-items: center;
                gap: 24px;
            }

            .cover-img-wrap {
                width: 90px;
                height: 120px;
                border-radius: 8px;
                overflow: hidden;
                background: #3d3a5c;
                flex-shrink: 0;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .cover-img-wrap img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: block;
            }

            .cover-img-wrap .no-cover i {
                font-size: 32px;
                color: #6c63b8;
            }

            .cover-info { flex: 1; }

            .cover-info .book-label {
                font-size: 12px;
                color: #a8a4cc;
                margin-bottom: 4px;
            }

            .cover-info .book-name {
                font-size: 18px;
                font-weight: 600;
                color: #eeedf8;
                margin-bottom: 2px;
            }

            .cover-info .book-author-label {
                font-size: 14px;
                color: #a8a4cc;
            }

            /* ── Form body ── */
            .form-body {
                padding: 28px 32px;
            }

            .form-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 18px;
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

            .input-wrap input,
            .input-wrap select {
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
                appearance: none;
            }

            .input-wrap input:focus,
            .input-wrap select:focus {
                border-color: #6c63b8;
                box-shadow: 0 0 0 3px rgba(108,99,184,0.12);
                background: #ebe9f5;
            }

            /* condition hint */
            .condition-hint {
                font-size: 12px;
                color: #9b99b8;
                margin-top: 2px;
            }

            .condition-hint span {
                font-weight: 600;
                color: #6c63b8;
            }

            /* file input */
            .file-field input[type="file"] {
                width: 100%;
                padding: 9px 12px;
                border: 1px dashed #b0aec8;
                border-radius: 8px;
                background: #eceaf4;
                color: #4a4868;
                font-size: 13px;
                font-family: Arial, sans-serif;
                cursor: pointer;
                outline: none;
            }

            .file-field input[type="file"]:focus {
                border-color: #6c63b8;
            }

            .file-note {
                font-size: 12px;
                color: #9b99b8;
                margin-top: 3px;
            }

            /* ── Divider ── */
            .form-divider {
                height: 1px;
                background: #d4d2e3;
                margin: 24px 0;
            }

            /* ── Actions ── */
            .form-actions {
                display: flex;
                justify-content: flex-end;
                gap: 10px;
            }

            .btn-secondary {
                height: 40px;
                padding: 0 20px;
                background: #eceaf4;
                color: #4a4868;
                border: 1px solid #d4d2e3;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                font-family: Arial, sans-serif;
                display: flex;
                align-items: center;
                gap: 7px;
                text-decoration: none;
                transition: background 0.15s;
            }

            .btn-secondary:hover { background: #dddaf0; }
            .btn-secondary i { font-size: 16px; }

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

            @media (max-width: 600px) {
                .form-grid { grid-template-columns: 1fr; }
                .field.full-width { grid-column: 1; }
                .cover-strip { flex-direction: column; align-items: flex-start; }
                .form-body { padding: 20px; }
                .page-wrapper { padding: 20px 16px 40px; }
            }
        </style>
    </head>
    <body>

        <%BookDTO book = (BookDTO)request.getAttribute("book"); %>

        <!-- Navbar -->
        <nav class="navbar">
            <a href="#" class="navbar-brand">
                <div class="nav-icon"><i class="ti ti-book-2"></i></div>
                <span>E-lib Store</span>
            </a>
            <a href="javascript:history.back()" class="navbar-back">
                <i class="ti ti-arrow-left"></i>
                Back to dashboard
            </a>
        </nav>

        <div class="page-wrapper">

            <div class="section-heading">
                <i class="ti ti-edit"></i>
                <h2>Edit book details</h2>
            </div>

            <div class="edit-card">

                <!-- Cover preview strip -->
                <div class="cover-strip">
                    <div class="cover-img-wrap">
                        <img src="BookCoverDisplay?bookid=<%=book.getBookid()%>"
                             alt="<%=book.getBooktitle()%>"
                             onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                        <div class="no-cover" style="display:none; width:100%; height:100%; align-items:center; justify-content:center;">
                            <i class="ti ti-book-off"></i>
                        </div>
                    </div>
                    <div class="cover-info">
                        <div class="book-label">Editing</div>
                        <div class="book-name"><%=book.getBooktitle()%></div>
                        <div class="book-author-label">by <%=book.getBookauthor()%></div>
                    </div>
                </div>

                <!-- Form -->
                <div class="form-body">
                    <form action="UpdateSellerBooks" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="bookid" value="<%=book.getBookid()%>" />

                        <div class="form-grid">

                            <div class="field">
                                <label for="booktitle">Book title</label>
                                <div class="input-wrap">
                                    <i class="ti ti-books icon-left"></i>
                                    <input type="text" id="booktitle" name="booktitle"
                                           value="<%=book.getBooktitle()%>" />
                                </div>
                            </div>

                            <div class="field">
                                <label for="bookauthor">Author</label>
                                <div class="input-wrap">
                                    <i class="ti ti-user icon-left"></i>
                                    <input type="text" id="bookauthor" name="bookauthor"
                                           value="<%=book.getBookauthor()%>" />
                                </div>
                            </div>

                            <div class="field">
                                <label for="bookprice">Price (₹)</label>
                                <div class="input-wrap">
                                    <i class="ti ti-currency-rupee icon-left"></i>
                                    <input type="number" id="bookprice" name="bookprice"
                                           value="<%=book.getBookprice()%>" required />
                                </div>
                            </div>

                            <div class="field">
                                <label for="bookcondition">Condition</label>
                                <div class="input-wrap">
                                    <i class="ti ti-tag icon-left"></i>
                                    <select id="bookcondition" name="bookcondition">
                                        <option value="New" <%="New".equals(book.getBookcondition()) ? "selected" : ""%>>New</option>
                                        <option value="Old" <%="Old".equals(book.getBookcondition()) ? "selected" : ""%>>Old</option>
                                    </select>
                                </div>
                                <div class="condition-hint">Current: <span><%=book.getBookcondition()%></span></div>
                            </div>

                            <div class="field full-width file-field">
                                <label for="bookcover">Replace cover image</label>
                                <input type="file" id="bookcover" name="bookcover" accept="image/*" />
                                <div class="file-note">Leave empty to keep the existing cover.</div>
                            </div>

                        </div>

                        <div class="form-divider"></div>

                        <div class="form-actions">
                            <a href="javascript:history.back()" class="btn-secondary">
                                <i class="ti ti-x"></i>
                                Cancel
                            </a>
                            <button type="submit" class="btn-primary">
                                <i class="ti ti-device-floppy"></i>
                                Save changes
                            </button>
                        </div>

                    </form>
                </div>

            </div>
        </div>

    </body>
</html>