using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using final.Models;
using System.Reflection;
using final.DTO;
using System.Text.RegularExpressions;
using Microsoft.AspNetCore.Authorization;

namespace final.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderNoLoginController : ControllerBase
    {
        private readonly EcommerceContext _context;

        public OrderNoLoginController(EcommerceContext context)
        {
            _context = context;
        }

        // GET: api/OrderNoLogin
        [HttpGet]
        [Authorize]
        public async Task<ActionResult<IEnumerable<OrderNoLogin>>> GetOrderNoLogins()
        {
            return await _context.OrderNoLogins
                                .Include(o => o.Customer)
                                //.Where(c => c.Customer.LastName == "Andersson")
                                .Include(o => o.OrderNoLoginProducts)
                                .ThenInclude(op => op.Product)
                                .ThenInclude(p => p.Category)                                
                                .ToListAsync();
        }

        // GET: api/OrderNoLogin/5
        [HttpGet("{id}")]
        public async Task<ActionResult<OrderNoLogin>> GetOrderNoLogin(int id)
        {
            var orderNoLogin = await _context.OrderNoLogins
                                .Include(o => o.Customer)
                                .Include(o => o.OrderNoLoginProducts)
                                .ThenInclude(op => op.Product)
                                .FirstOrDefaultAsync(o => o.Id == id);

            if (orderNoLogin == null)
            {
                return NotFound();
            }

            return orderNoLogin;
        }

        // PUT: api/OrderNoLogin/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutOrderNoLogin(int id, OrderNoLogin orderNoLogin)
        {
            if (id != orderNoLogin.Id)
            {
                return BadRequest();
            }

            _context.Entry(orderNoLogin).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!OrderNoLoginExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/OrderNoLogin
        [HttpPost]
        public async Task<ActionResult<OrderNoLogin>> PostOrderNoLogin(OrderDTO orderDTO)
        {
            var customer = new CustomerNoLogin();
            customer.FirstName = orderDTO.customer.FirstName;
            customer.LastName = orderDTO.customer.LastName;
            customer.Email = orderDTO.customer.Email;
            customer.Street = orderDTO.customer.Street;
            customer.Zipcode = orderDTO.customer.Zipcode;
            customer.City = orderDTO.customer.City;

            var order = new OrderNoLogin();
            order.Customer = customer;

            foreach (ProductDTO productDTO in orderDTO.products)
            {
                var product = await _context.Products.FindAsync(productDTO.Id);

                if (product is null)
                    return NotFound();

                var orderProduct = new OrderNoLoginProduct();
                orderProduct.Quantity = productDTO.Quantity;
                orderProduct.Price = (decimal)product.Price!;
                orderProduct.Product = product;

                order.OrderNoLoginProducts.Add(orderProduct);
            }

            _context.OrderNoLogins.Add(order);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetOrderNoLogin", new { id = order.Id }, order);
        }

        // DELETE: api/OrderNoLogin/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteOrderNoLogin(int id)
        {
            var orderNoLogin = await _context.OrderNoLogins.FindAsync(id);
            if (orderNoLogin == null)
            {
                return NotFound();
            }

            _context.OrderNoLogins.Remove(orderNoLogin);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool OrderNoLoginExists(int id)
        {
            return _context.OrderNoLogins.Any(e => e.Id == id);
        }
    }

}
