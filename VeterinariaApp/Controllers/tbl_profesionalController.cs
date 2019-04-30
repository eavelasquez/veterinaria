using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using VeterinariaApp.Models;

namespace VeterinariaApp.Controllers
{
    public class tbl_profesionalController : Controller
    {
        private db_veterinariaEntities db = new db_veterinariaEntities();

        // GET: tbl_profesional
        public ActionResult Index()
        {
            return View(db.tbl_profesional.ToList());
        }

        // GET: tbl_profesional/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_profesional tbl_profesional = db.tbl_profesional.Find(id);
            if (tbl_profesional == null)
            {
                return HttpNotFound();
            }
            return View(tbl_profesional);
        }

        // GET: tbl_profesional/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: tbl_profesional/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "codigo_pfl,nombre_pfl,apellido_pfl,telefono_pfl,celular_pfl")] tbl_profesional tbl_profesional)
        {
            if (ModelState.IsValid)
            {
                db.tbl_profesional.Add(tbl_profesional);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(tbl_profesional);
        }

        // GET: tbl_profesional/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_profesional tbl_profesional = db.tbl_profesional.Find(id);
            if (tbl_profesional == null)
            {
                return HttpNotFound();
            }
            return View(tbl_profesional);
        }

        // POST: tbl_profesional/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "codigo_pfl,nombre_pfl,apellido_pfl,telefono_pfl,celular_pfl")] tbl_profesional tbl_profesional)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tbl_profesional).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(tbl_profesional);
        }

        // GET: tbl_profesional/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_profesional tbl_profesional = db.tbl_profesional.Find(id);
            if (tbl_profesional == null)
            {
                return HttpNotFound();
            }
            return View(tbl_profesional);
        }

        // POST: tbl_profesional/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            tbl_profesional tbl_profesional = db.tbl_profesional.Find(id);
            db.tbl_profesional.Remove(tbl_profesional);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
