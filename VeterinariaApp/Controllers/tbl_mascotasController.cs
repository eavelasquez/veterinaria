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
    public class tbl_mascotasController : Controller
    {
        private db_veterinariaEntities db = new db_veterinariaEntities();

        // GET: tbl_mascotas
        public ActionResult Index()
        {
            var tbl_mascotas = db.tbl_mascotas.Include(t => t.tbl_cliente).Include(t => t.tbl_especie).Include(t => t.tbl_raza);
            return View(tbl_mascotas.ToList());
        }

        // GET: tbl_mascotas/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_mascotas tbl_mascotas = db.tbl_mascotas.Find(id);
            if (tbl_mascotas == null)
            {
                return HttpNotFound();
            }
            return View(tbl_mascotas);
        }

        // GET: tbl_mascotas/Create
        public ActionResult Create()
        {
            ViewBag.id_c = new SelectList(db.tbl_cliente, "id_c", "nombre_c");
            ViewBag.codigo_e = new SelectList(db.tbl_especie, "codigo_e", "nombre_e");
            ViewBag.codigo_r = new SelectList(db.tbl_raza, "codigo_r", "nombre_r");
            return View();
        }

        // POST: tbl_mascotas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id_m,nombre_m,descripcion_m,edad_m,sexo_m,fecha_nacimiento_m,codigo_e,id_c,codigo_r")] tbl_mascotas tbl_mascotas)
        {
            if (ModelState.IsValid)
            {
                db.tbl_mascotas.Add(tbl_mascotas);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.id_c = new SelectList(db.tbl_cliente, "id_c", "nombre_c", tbl_mascotas.id_c);
            ViewBag.codigo_e = new SelectList(db.tbl_especie, "codigo_e", "nombre_e", tbl_mascotas.codigo_e);
            ViewBag.codigo_r = new SelectList(db.tbl_raza, "codigo_r", "nombre_r", tbl_mascotas.codigo_r);
            return View(tbl_mascotas);
        }

        // GET: tbl_mascotas/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_mascotas tbl_mascotas = db.tbl_mascotas.Find(id);
            if (tbl_mascotas == null)
            {
                return HttpNotFound();
            }
            ViewBag.id_c = new SelectList(db.tbl_cliente, "id_c", "nombre_c", tbl_mascotas.id_c);
            ViewBag.codigo_e = new SelectList(db.tbl_especie, "codigo_e", "nombre_e", tbl_mascotas.codigo_e);
            ViewBag.codigo_r = new SelectList(db.tbl_raza, "codigo_r", "nombre_r", tbl_mascotas.codigo_r);
            return View(tbl_mascotas);
        }

        // POST: tbl_mascotas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id_m,nombre_m,descripcion_m,edad_m,sexo_m,fecha_nacimiento_m,codigo_e,id_c,codigo_r")] tbl_mascotas tbl_mascotas)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tbl_mascotas).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.id_c = new SelectList(db.tbl_cliente, "id_c", "nombre_c", tbl_mascotas.id_c);
            ViewBag.codigo_e = new SelectList(db.tbl_especie, "codigo_e", "nombre_e", tbl_mascotas.codigo_e);
            ViewBag.codigo_r = new SelectList(db.tbl_raza, "codigo_r", "nombre_r", tbl_mascotas.codigo_r);
            return View(tbl_mascotas);
        }

        // GET: tbl_mascotas/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_mascotas tbl_mascotas = db.tbl_mascotas.Find(id);
            if (tbl_mascotas == null)
            {
                return HttpNotFound();
            }
            return View(tbl_mascotas);
        }

        // POST: tbl_mascotas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            tbl_mascotas tbl_mascotas = db.tbl_mascotas.Find(id);
            db.tbl_mascotas.Remove(tbl_mascotas);
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
